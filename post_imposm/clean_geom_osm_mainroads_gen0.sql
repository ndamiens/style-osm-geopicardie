--
-- osm_mainroads_gen0
--

begin;

-- Changement de type de géométrie de osm_mainroads_gen0
ALTER TABLE osm_mainroads_gen0
  ALTER COLUMN geometry 
  SET DATA TYPE geometry(Linestring, 900913);

commit;