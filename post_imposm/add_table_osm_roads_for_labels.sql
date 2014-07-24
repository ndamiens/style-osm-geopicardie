-- Table: osm_roads_for_labels_xx

DROP TABLE if exists osm_roads_for_labels_name;
DROP TABLE if exists osm_roads_for_labels_ref;
DROP TABLE if exists osm_roads_for_labels_int_ref;

-- Création des tables
CREATE TABLE osm_roads_for_labels_name
(
  class character varying(15),
  type character varying(255),
  name character varying(255),
  geometry geometry(LineString,900913)
)
WITH (
  OIDS=FALSE
);

CREATE TABLE osm_roads_for_labels_ref
(
  class character varying(15),
  type character varying(255),
  ref character varying(255),
  geometry geometry(LineString,900913)
)
WITH (
  OIDS=FALSE
);

CREATE TABLE osm_roads_for_labels_int_ref
(
  class character varying(15),
  type character varying(255),
  int_ref character varying(255),
  geometry geometry(LineString,900913)
)
WITH (
  OIDS=FALSE
);

-- Création des index

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
	WHERE r.name IS NOT NULL AND r.name != '' AND r.class != 'railways'
	GROUP BY r.class, r.type, r.name
	) as t1,
	(SELECT (ST_Dump(ST_Multi(ST_LineMerge(ST_Union(geometry))))).geom AS geometry, s.class, s.type, s.name
	FROM osm_roads_n_railways as s
	WHERE s.name IS NOT NULL AND s.name != '' AND s.class != 'railways'
	GROUP BY s.class, s.type, s.name
	) as t2
WHERE
	t1.class = t2.class AND
	t1.type = t2.type AND
	t1.name = t2.name
;

INSERT INTO osm_roads_for_labels_ref (
    class,
    type,
    ref,
    geometry)
SELECT t1.class, t1.type, t1.ref, t2.geometry
FROM
	(SELECT r.class, r.type, r.ref
	FROM osm_roads_n_railways as r
	WHERE r.name IS NOT NULL AND r.ref != '' AND r.class != 'railways'
	GROUP BY r.class, r.type, r.ref
	) as t1,
	(SELECT (ST_Dump(ST_Multi(ST_LineMerge(ST_Union(geometry))))).geom AS geometry, s.class, s.type, s.ref
	FROM osm_roads_n_railways as s
	WHERE s.name IS NOT NULL AND s.ref != '' AND s.class != 'railways'
	GROUP BY s.class, s.type, s.ref
	) as t2
WHERE
	t1.class = t2.class AND
	t1.type = t2.type AND
	t1.ref = t2.ref
;



-- Alimentation de la table osm_roads_for_labels_int_ref à partir de la table osm_roads_n_railways
INSERT INTO osm_roads_for_labels_ref (
    class,
    type,
    ref,
    geometry)
SELECT t1.class, t1.type, t1.int_ref, t2.geometry
FROM
	(SELECT r.class, r.type, r.int_ref
	FROM osm_roads_n_railways as r
	WHERE r.name IS NOT NULL AND r.int_ref != '' AND r.class != 'railways'
	GROUP BY r.class, r.type, r.int_ref
	) as t1,
	(SELECT (ST_Dump(ST_Multi(ST_LineMerge(ST_Union(geometry))))).geom AS geometry, s.class, s.type, s.int_ref
	FROM osm_roads_n_railways as s
	WHERE s.name IS NOT NULL AND s.int_ref != '' AND s.class != 'railways'
	GROUP BY s.class, s.type, s.int_ref
	) as t2
WHERE
	t1.class = t2.class AND
	t1.type = t2.type AND
	t1.int_ref = t2.int_ref
;
