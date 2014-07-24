-- "améliorations" de la base OSM après l'import

begin;

-- Rendre valides les géométries qui ne le sont pas
UPDATE osm_landusages SET geometry = ST_MakeValid(geometry) WHERE NOT ST_IsValid(geometry);
UPDATE osm_waterareas SET geometry = ST_MakeValid(geometry) WHERE NOT ST_IsValid(geometry);
UPDATE osm_buildings SET geometry = ST_MakeValid(geometry) WHERE NOT ST_IsValid(geometry);

commit;
