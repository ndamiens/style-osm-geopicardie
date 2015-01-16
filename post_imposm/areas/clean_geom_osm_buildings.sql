--
-- osm_buildings
--

begin;

-- Suppression des objets non surfaciques
DELETE FROM osm_buildings
  WHERE ST_IsEmpty(ST_CollectionExtract(geometry, 3));

-- Suppression des composantes non surfaciques
UPDATE osm_buildings
  SET geometry = ST_CollectionExtract(geometry, 3)
  WHERE ST_GeometryType(geometry) = 'ST_GeometryCollection';

UPDATE osm_buildings
  SET geometry = ST_CollectionExtract(ST_MakeValid(geometry), 3)
  WHERE not ST_IsValid(geometry);

-- Changement de type de géométrie
ALTER TABLE osm_buildings
  ALTER COLUMN geometry 
  SET DATA TYPE geometry(MultiPolygon, 3857) 
  USING ST_Multi(geometry);

commit;