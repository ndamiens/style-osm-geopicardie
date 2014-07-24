-- Table: osm_roads_n_railways_gen1

DROP TABLE if exists osm_roads_n_railways_gen1;

-- Création de la table
CREATE TABLE osm_roads_n_railways_gen1
(
  osm_id integer NOT NULL,
  class character varying(15),
  type character varying(255),
  name character varying(255),
  tunnel smallint,
  bridge smallint,
  oneway smallint,
  ref character varying(255),
  int_ref character varying(255),
  layer integer,
  z_order smallint,
  access character varying(255),
  service character varying(255),
  usage character varying(255),
  geometry geometry(LineString,900913),
  CONSTRAINT osm_roads_n_railways_gen1_pkey PRIMARY KEY (osm_id)
)
WITH (
  OIDS=FALSE
);

-- Création des index

-- Alimentation de la table osm_roads_n_railways_gen1 à partir de la table osm_motorways
INSERT INTO osm_roads_n_railways_gen1 (
    osm_id,
    class,
    type,
    name,
    tunnel,
    bridge,
    oneway,
    layer,
    ref,
    int_ref,
    z_order,
    access,
    geometry)
SELECT
    osm_id,
    'motorways'::character varying,
    type,
    name,
    tunnel,
    bridge,
    oneway,
    layer,
    ref,
    int_ref,
    z_order,
    access,
    geometry FROM osm_motorways_gen1;


-- Alimentation de la table osm_roads_n_railways_gen1 à partir de la table osm_mainroads_gen1
INSERT INTO osm_roads_n_railways_gen1 (
    osm_id,
    class,
    type,
    name,
    tunnel,
    bridge,
    oneway,
    layer,
    ref,
    int_ref,
    z_order,
    access,
    geometry)
SELECT
    osm_id,
    'mainroads'::character varying,
    type,
    name,
    tunnel,
    bridge,
    oneway,
    layer,
    ref,
    int_ref,
    z_order,
    access,
    geometry FROM osm_mainroads_gen1;


-- Alimentation de la table osm_roads_n_railways à partir de la table osm_railways
INSERT INTO osm_roads_n_railways_gen1 (
    osm_id,
    class,
    type,
    name,
    tunnel,
    bridge,
    oneway,
    layer,
    service,
    usage,
    z_order,
    geometry)
SELECT
    osm_id,
    'railways'::character varying,
    type,
    name,
    tunnel,
    bridge,
    0,
    layer,
    service,
    usage,
    z_order,
    geometry FROM osm_railways_gen1;


