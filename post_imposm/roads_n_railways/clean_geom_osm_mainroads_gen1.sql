--
-- osm_mainroads_gen1
--

begin;

-- Changement de type de géométrie de osm_mainroads_gen1
ALTER TABLE osm_mainroads_gen1
  ALTER COLUMN geometry 
  SET DATA TYPE geometry(Linestring, 900913);

commit;