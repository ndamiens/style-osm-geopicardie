-- Table: osm_roads_for_labels_xx

DROP TABLE if exists osm_roads_for_labels_name;
DROP TABLE if exists osm_roads_for_labels_ref;
DROP TABLE if exists osm_roads_for_labels_int_ref;

-- Création des tables
CREATE TABLE osm_roads_for_labels_name
(
  class character varying,
  type character varying,
  name character varying,
  geometry geometry(LineString,3857)
)
WITH (
  OIDS=FALSE
);

CREATE TABLE osm_roads_for_labels_ref
(
  class character varying,
  type character varying,
  ref character varying,
  geometry geometry(LineString,3857)
)
WITH (
  OIDS=FALSE
);

CREATE TABLE osm_roads_for_labels_int_ref
(
  class character varying,
  type character varying,
  int_ref character varying,
  geometry geometry(LineString,3857)
)
WITH (
  OIDS=FALSE
);

-- Création des index
CREATE INDEX osm_roads_for_labels_name_geom
  ON osm_roads_for_labels_name
  USING gist
  (geometry );
ALTER TABLE osm_roads_for_labels_name CLUSTER ON osm_roads_for_labels_name_geom;

CREATE INDEX osm_roads_for_labels_ref_geom
  ON osm_roads_for_labels_ref
  USING gist
  (geometry );
ALTER TABLE osm_roads_for_labels_ref CLUSTER ON osm_roads_for_labels_ref_geom;

CREATE INDEX osm_roads_for_labels_int_ref_geom
  ON osm_roads_for_labels_int_ref
  USING gist
  (geometry );
ALTER TABLE osm_roads_for_labels_int_ref CLUSTER ON osm_roads_for_labels_int_ref_geom;

-- Alimentation de la table osm_roads_for_labels_name à partir de la table osm_roads_n_railways
INSERT INTO osm_roads_for_labels_name (
    class,
    type,
    name,
    geometry)
SELECT t1.class, t1.type, t1.name, t2.geometry
FROM
	(SELECT r.class, r.type, r.name
	FROM osm_roads_n_railways as r
	WHERE r.name IS NOT NULL AND r.name != '' AND r.type != 'rail'
	GROUP BY r.class, r.type, r.name
	) as t1,
	(SELECT (ST_Dump(ST_Multi(ST_LineMerge(ST_Union(geometry))))).geom AS geometry, s.class, s.type, s.name
	FROM osm_roads_n_railways as s
	WHERE s.name IS NOT NULL AND s.name != '' AND s.type != 'rail'
	GROUP BY s.class, s.type, s.name
	) as t2
WHERE
	t1.class = t2.class AND
	t1.type = t2.type AND
	t1.name = t2.name
;

-- Alimentation de la table osm_roads_for_labels_ref à partir de la table osm_roads_n_railways
INSERT INTO osm_roads_for_labels_ref (
    class,
    type,
    ref,
    geometry)
SELECT t1.class, t1.type, t1.ref, t2.geometry
FROM
	(SELECT r.class, r.type, r.ref
	FROM osm_roads_n_railways as r
	WHERE r.name IS NOT NULL AND r.ref != '' AND r.type != 'rail'
	GROUP BY r.class, r.type, r.ref
	) as t1,
	(SELECT (ST_Dump(ST_Multi(ST_LineMerge(ST_Union(geometry))))).geom AS geometry, s.class, s.type, s.ref
	FROM osm_roads_n_railways as s
	WHERE s.name IS NOT NULL AND s.ref != '' AND s.type != 'rail'
	GROUP BY s.class, s.type, s.ref
	) as t2
WHERE
	t1.class = t2.class AND
	t1.type = t2.type AND
	t1.ref = t2.ref
;


-- Alimentation de la table osm_roads_for_labels_int_ref à partir de la table osm_roads_n_railways
INSERT INTO osm_roads_for_labels_int_ref (
    class,
    type,
    int_ref,
    geometry)
SELECT t1.class, t1.type, t1.int_ref, t2.geometry
FROM
	(SELECT r.class, r.type, r.int_ref
	FROM osm_roads_n_railways as r
	WHERE r.name IS NOT NULL AND r.int_ref != '' AND r.type != 'rail'
	GROUP BY r.class, r.type, r.int_ref
	) as t1,
	(SELECT (ST_Dump(ST_Multi(ST_LineMerge(ST_Union(geometry))))).geom AS geometry, s.class, s.type, s.int_ref
	FROM osm_roads_n_railways as s
	WHERE s.name IS NOT NULL AND s.int_ref != '' AND s.type != 'rail'
	GROUP BY s.class, s.type, s.int_ref
	) as t2
WHERE
	t1.class = t2.class AND
	t1.type = t2.type AND
	t1.int_ref = t2.int_ref
;