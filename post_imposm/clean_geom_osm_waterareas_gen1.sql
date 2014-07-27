--
-- osm_waterareas_gen1
--


-- Suppression des objets simples non surfaciques
DELETE FROM osm_waterareas_gen1 WHERE ST_GeometryType(geometry) IN ('ST_Point', 'ST_Linestring', 'ST_MultiPoint', 'ST_MultiLinestring');


-- Suppression des composantes des géométries non surfaciques de osm_waterareas_gen1
with geom_comps as (
	select osm_id, (ST_Dump(geometry)).geom as geom_comp
	from osm_waterareas_gen1
	where ST_NumGeometries(geometry) > 1
),
not_polygon_comps as (
	select osm_id, ST_GeometryType(geom_comp)
	from geom_comps
	where ST_GeometryType(geom_comp) not in ('ST_Polygon')
),
heter_comps as (
	select g.osm_id, ST_GeometryType(g.geom_comp)
	from geom_comps as g, not_polygon_comps as n
	where g.osm_id = n.osm_id
),
new_geoms as (
	select g.osm_id, ST_Collect(g.geom_comp) as geometry, ST_GeometryType(ST_Collect(g.geom_comp)) as geom_type
	from geom_comps as g, not_polygon_comps as n
	where g.osm_id = n.osm_id and
	 ST_GeometryType(g.geom_comp) = 'ST_Polygon'
	group by g.osm_id
),
not_polygon_objects as (
	select g.osm_id
	from heter_comps as g
	where g.osm_id NOT IN (
		SELECT osm_id
		FROM new_geoms
	)
)

DELETE FROM osm_waterareas_gen1
WHERE osm_id IN (
	SELECT osm_id from not_polygon_objects
	)
;

UPDATE osm_waterareas_gen1
SET geometry = new_geoms.geometry
FROM new_geoms
WHERE new_geoms.osm_id = osm_waterareas_gen1.osm_id
;

-- Changement de type de géométrie de osm_waterareas_gen1
ALTER TABLE osm_waterareas_gen1
  ALTER COLUMN geometry 
  SET DATA TYPE geometry(MultiPolygon, 900913) 
  USING ST_Multi(geometry);
