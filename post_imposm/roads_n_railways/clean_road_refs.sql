-- post-traitements sur la base OSM après exécution de imposm
-- ajout d'une espace dans les références de voies françaises là où il n'y en a pas

begin;

UPDATE osm_roads_n_railways
	SET ref=substring(ref,'^([ANDC])')||' '||substring(ref, '^[A-Z]([0-9]+)')
	WHERE ref ~ '^[ANDC][0-9]+$'
		AND type != 'rail';

commit;
