DROP TABLE if exists osm_areas_for_labels;


-- Création des tables
CREATE TABLE osm_areas_for_labels
(
  id serial,
  type character varying(255),
  name character varying(255),
  area real,
  geometry geometry(Polygon,900913)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE osm_areas_for_labels
  OWNER TO "user";

-- Alimentation de la table osm_areas_for_labels à partir de la table osm_landusages
INSERT INTO osm_areas_for_labels (
    type,
    name,
    area,
    geometry)
SELECT t1.type, t1.name, ST_Area(t2.geometry) as area, t2.geometry
FROM
	(SELECT r.type, r.name
	FROM osm_landusages as r
	WHERE r.name IS NOT NULL AND r.name != ''
	GROUP BY r.type, r.name
	) as t1,
	(SELECT (ST_Dump(ST_Multi(ST_Union(ST_Buffer(geometry, 10))))).geom AS geometry, s.type, s.name
	FROM osm_landusages as s
	WHERE s.name IS NOT NULL AND s.name != ''
	GROUP BY s.type, s.name
	) as t2
WHERE
	t1.type = t2.type AND
	t1.name = t2.name
;

-- Alimentation de la table osm_areas_for_labels à partir de la table osm_buildings
INSERT INTO osm_areas_for_labels (
    type,
    name,
    area,
    geometry)
SELECT 'building', name, ST_Area(geometry) as area, geometry
FROM osm_buildings
WHERE name IS NOT NULL AND name != ''
    AND ST_NumGeometries(geometry) = 1
    AND ST_NumInteriorRings(geometry) = 0
;

INSERT INTO osm_areas_for_labels (
    type,
    name,
    area,
    geometry)
SELECT 'building' as type, name, ST_Area(ST_MakePolygon(ST_Exteriorring( ST_geometryn( geometry, 1)))) as area, ST_MakePolygon(ST_Exteriorring( ST_geometryn( geometry, 1)))
FROM osm_buildings
WHERE name IS NOT NULL AND name != ''
    AND ST_NumGeometries(geometry) = 1
    AND ST_NumInteriorRings(geometry) > 0
;

-- Gros problème pour les noms très courants -> très gros polygones !
INSERT INTO osm_areas_for_labels (
    type,
    name,
    area,
    geometry)
SELECT 'building', name, ST_Area(ST_ConcaveHull(geometry,90)), ST_ConcaveHull(geometry,90)
FROM osm_buildings
WHERE name IS NOT NULL AND name != ''
    AND ST_NumGeometries(geometry) > 1
;


