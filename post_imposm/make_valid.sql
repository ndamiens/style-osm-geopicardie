-- post-traitements sur la base OSM après exécution de imposm
-- rendre valides les géométries qui ne le sont pas (polygones mal fermés, auto-intersection...)

begin;

UPDATE osm_landusages SET geometry = ST_MakeValid(geometry) WHERE NOT ST_IsValid(geometry);
UPDATE osm_waterareas SET geometry = ST_MakeValid(geometry) WHERE NOT ST_IsValid(geometry);
UPDATE osm_buildings SET geometry = ST_MakeValid(geometry) WHERE NOT ST_IsValid(geometry);

commit;
