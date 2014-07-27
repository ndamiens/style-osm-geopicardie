--
-- osm_motorways_gen0
--


-- Changement de type de géométrie de osm_motorways_gen0
ALTER TABLE osm_motorways_gen0
  ALTER COLUMN geometry 
  SET DATA TYPE geometry(Linestring, 900913);
