create index osm_mw_name on osm_motorways (name);
create index osm_mr_name on osm_mainroads (name);
create index osm_mi_name on osm_minorroads (name);
create index osm_mw_ref on osm_motorways (ref);
create index osm_mr_ref on osm_mainroads (ref);
create index osm_mi_ref on osm_minorroads (ref);

alter view osm_roads rename to osm_roads_view;
select * into osm_roads from osm_roads_view;

create index osm_road_idx_geom on osm_roads using gist (geometry);
create index osm_road_idx_name on osm_roads (name);
create index osm_road_idx_ref on osm_roads (ref);
