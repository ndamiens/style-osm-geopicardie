-- post-traitements sur la base OSM après exécution de imposm
-- suppression des tronçons de voies généralisés de longueur nulle

begin;

DELETE FROM osm_motorways_gen0 WHERE st_length(geometry) = 0;
DELETE FROM osm_motorways_gen1 WHERE st_length(geometry) = 0;
DELETE FROM osm_mainroads_gen0 WHERE st_length(geometry) = 0;
DELETE FROM osm_mainroads_gen1 WHERE st_length(geometry) = 0;
DELETE FROM osm_railways_gen0 WHERE st_length(geometry) = 0;
DELETE FROM osm_railways_gen1 WHERE st_length(geometry) = 0;

commit;
