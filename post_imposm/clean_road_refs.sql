-- "améliorations" de la base OSM après l'import

begin;

-- Mettre les espaces sur les références où il n'y en a pas
update osm_motorways set ref=substring(ref,'^([ANDC])')||' '||substring(ref, '^[A-Z]([0-9]+)') where ref ~ '^[ANDC][0-9]+$';
update osm_mainroads set ref=substring(ref,'^([ANDC])')||' '||substring(ref, '^[A-Z]([0-9]+)') where ref ~ '^[ANDC][0-9]+$';
update osm_minorroads set ref=substring(ref,'^([ANDC])')||' '||substring(ref, '^[A-Z]([0-9]+)') where ref ~ '^[ANDC][0-9]+$';

commit;
