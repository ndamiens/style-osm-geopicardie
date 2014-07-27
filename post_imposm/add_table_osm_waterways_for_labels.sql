-- Table: osm_roads_for_labels_xx

DROP TABLE if exists osm_waterways_for_labels;

-- Création des tables
CREATE TABLE osm_waterways_for_labels
(
  class character varying(255),
  type character varying(255),
  name character varying(255),
  geometry geometry(LineString,900913)
)
WITH (
  OIDS=FALSE
);


-- Création des index
CREATE INDEX osm_waterways_for_labels_geom
  ON osm_waterways_for_labels
  USING gist
  (geometry );
ALTER TABLE osm_waterways_for_labels CLUSTER ON osm_waterways_for_labels_geom;

-- Alimentation de la table osm_roads_for_labels_name à partir de la table osm_waterways
INSERT INTO osm_waterways_for_labels (
    type,
    name,
    geometry)
SELECT t1.type, t1.name, t2.geometry
FROM
	(SELECT r.type, r.name
	FROM osm_waterways as r
	WHERE r.name IS NOT NULL AND r.name != ''
	GROUP BY r.type, r.name
	) as t1,
	(SELECT (ST_Dump(ST_Multi(ST_LineMerge(ST_Union(geometry))))).geom AS geometry, s.type, s.name
	FROM osm_waterways as s
	WHERE s.name IS NOT NULL AND s.name != ''
	GROUP BY s.type, s.name
	) as t2
WHERE
	t1.type = t2.type AND
	t1.name = t2.name
;
