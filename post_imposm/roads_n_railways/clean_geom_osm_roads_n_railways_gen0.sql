--
-- osm_roads_n_railways_gen0
--

begin;

-- Changement de type de géométrie de osm_roads_n_railways_gen0
ALTER TABLE osm_roads_n_railways_gen0
  ALTER COLUMN geometry 
  SET DATA TYPE geometry(Linestring, 3857);

commit;