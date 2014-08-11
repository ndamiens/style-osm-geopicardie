-- Table: osm_roads_n_railways

DROP TABLE if exists osm_roads_n_railways;

-- Création de la table
CREATE TABLE osm_roads_n_railways
(
  osm_id integer NOT NULL,
  class character varying(255),
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
  geometry geometry(LineString,900913)
  --Suppression de la clé primaire car plusieurs objets de cette
  --doivent pouvoir avoir le même osm_id (à vérifier)
  --CONSTRAINT osm_roads_n_railways_pkey PRIMARY KEY (osm_id)
)
WITH (
  OIDS=FALSE
);

-- Index: osm_roads_n_railways_geom
CREATE INDEX osm_roads_n_railways_geom
  ON osm_roads_n_railways
  USING gist
  (geometry );
ALTER TABLE osm_roads_n_railways CLUSTER ON osm_roads_n_railways_geom;

-- Alimentation de la table osm_roads_n_railways à partir de la table osm_motorways
INSERT INTO osm_roads_n_railways (
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
    geometry FROM osm_motorways;


-- Alimentation de la table osm_roads_n_railways à partir de la table osm_mainroads
INSERT INTO osm_roads_n_railways (
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
    geometry FROM osm_mainroads;


-- Alimentation de la table osm_roads_n_railways à partir de la table osm_minorroads
INSERT INTO osm_roads_n_railways (
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
    'minorroads'::character varying,
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
    geometry FROM osm_minorroads;


-- Alimentation de la table osm_roads_n_railways à partir de la table osm_railways
INSERT INTO osm_roads_n_railways (
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
    geometry FROM osm_railways;