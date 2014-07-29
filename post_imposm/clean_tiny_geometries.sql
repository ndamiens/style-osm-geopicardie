-- post-traitements sur la base OSM après exécution de imposm
-- suppression des tronçons de routes généralisés de longueur nulle

begin;

delete from osm_motorways_gen0 where st_length(geometry) = 0;
delete from osm_motorways_gen1 where st_length(geometry) = 0;

commit;
