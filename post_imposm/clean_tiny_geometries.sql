-- "améliorations" de la base OSM après l'import

begin;

-- Mettre les espaces sur les références où il n'y en a pas
update osm_motorways set ref=substring(ref,'^([ANDC])')||' '||substring(ref, '^[A-Z]([0-9]+)') where ref ~ '^[ANDC][0-9]+$';
update osm_mainroads set ref=substring(ref,'^([ANDC])')||' '||substring(ref, '^[A-Z]([0-9]+)') where ref ~ '^[ANDC][0-9]+$';
update osm_minorroads set ref=substring(ref,'^([ANDC])')||' '||substring(ref, '^[A-Z]([0-9]+)') where ref ~ '^[ANDC][0-9]+$';

UPDATE osm_landusages SET geometry = ST_MakeValid(geometry) WHERE NOT ST_IsValid(geometry);
UPDATE osm_waterareas SET geometry = ST_MakeValid(geometry) WHERE NOT ST_IsValid(geometry);
UPDATE osm_buildings SET geometry = ST_MakeValid(geometry) WHERE NOT ST_IsValid(geometry);

delete from osm_motorways_gen0 where st_length(geometry) = 0;

commit;
