-- post-traitements sur la base OSM après exécution de imposm
-- trucs sur la vue osm_raods_view

alter view osm_roads rename to osm_roads_view;
select * into osm_roads from osm_roads_view;

create index osm_road_idx_geom on osm_roads using gist (geometry);
create index osm_road_idx_name on osm_roads (name);
create index osm_road_idx_ref on osm_roads (ref);
