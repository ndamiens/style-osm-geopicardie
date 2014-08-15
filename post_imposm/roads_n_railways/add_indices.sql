-- post-traitements sur la base OSM après exécution de imposm
-- création d'index manquants sur des tables existantes

CREATE INDEX osm_roads_n_railways_name_idx
	ON osm_roads_n_railways (name);

CREATE INDEX osm_roads_n_railways_ref_idx
	ON osm_roads_n_railways (ref);

CREATE INDEX osm_roads_n_railways_int_ref_idx
	ON osm_roads_n_railways (int_ref);

CREATE INDEX osm_roads_n_railways_z_order_idx
	ON osm_roads_n_railways (z_order);
