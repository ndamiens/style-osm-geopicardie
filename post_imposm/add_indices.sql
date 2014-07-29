-- post-traitements sur la base OSM après exécution de imposm
-- création d'index manquants sur des tables existantes

create index osm_mw_name on osm_motorways (name);
create index osm_mr_name on osm_mainroads (name);
create index osm_mi_name on osm_minorroads (name);
create index osm_mw_ref on osm_motorways (ref);
create index osm_mr_ref on osm_mainroads (ref);
create index osm_mi_ref on osm_minorroads (ref);