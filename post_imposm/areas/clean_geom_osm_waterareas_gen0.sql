--
-- osm_waterareas_gen0
--

begin;

-- Suppression des objets non surfaciques
DELETE FROM osm_waterareas_gen0
  WHERE ST_IsEmpty(ST_CollectionExtract(geometry, 3));

-- Suppression des composantes non surfaciques
UPDATE osm_waterareas_gen0
  SET geometry = ST_CollectionExtract(geometry, 3)
  WHERE ST_GeometryType(geometry) = 'ST_GeometryCollection';

UPDATE osm_waterareas_gen0
  SET geometry = ST_CollectionExtract(ST_MakeValid(geometry), 3)
  WHERE not ST_IsValid(geometry);

-- Changement de type de géométrie
ALTER TABLE osm_waterareas_gen0
  ALTER COLUMN geometry 
  SET DATA TYPE geometry(MultiPolygon, 3857) 
  USING ST_Multi(geometry);

commit;