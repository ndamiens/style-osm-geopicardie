-- post-traitements sur la base OSM après exécution de imposm
-- suppression des tronçons de voies généralisés de longueur nulle

begin;

DELETE FROM osm_roads_n_railways_gen0 WHERE st_length(geometry) = 0;
DELETE FROM osm_roads_n_railways_gen1 WHERE st_length(geometry) = 0;

DELETE FROM osm_roads_n_railways_gen0 WHERE ST_NPoints(geometry) = 3 AND ST_StartPoint(geometry) = ST_EndPoint(geometry);
DELETE FROM osm_roads_n_railways_gen1 WHERE ST_NPoints(geometry) = 3 AND ST_StartPoint(geometry) = ST_EndPoint(geometry);

commit;
