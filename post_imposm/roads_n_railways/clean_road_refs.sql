-- post-traitements sur la base OSM après exécution de imposm
-- ajout d'une espace dans les références de voies françaises là où il n'y en a pas

begin;

update osm_motorways set ref=substring(ref,'^([ANDC])')||' '||substring(ref, '^[A-Z]([0-9]+)') where ref ~ '^[ANDC][0-9]+$';
update osm_mainroads set ref=substring(ref,'^([ANDC])')||' '||substring(ref, '^[A-Z]([0-9]+)') where ref ~ '^[ANDC][0-9]+$';
update osm_minorroads set ref=substring(ref,'^([ANDC])')||' '||substring(ref, '^[A-Z]([0-9]+)') where ref ~ '^[ANDC][0-9]+$';

commit;
