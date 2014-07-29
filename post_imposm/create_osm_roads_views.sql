CREATE OR REPLACE VIEW osm_roads AS 
        (        (         SELECT osm_motorways.osm_id,
                            osm_motorways.type,
                            osm_motorways.geometry::geometry(LineString, 900913) AS geometry,
                            osm_motorways.name,
                            osm_motorways.ref,
                            osm_motorways.int_ref,
                            osm_motorways.bridge,
                            osm_motorways.tunnel,
                            osm_motorways.oneway,
                            osm_motorways.layer,
                            osm_motorways.z_order,
                            osm_motorways.access,
                            NULL::text AS service,
                            NULL::text AS usage,
                            'motorways'::text AS class
                           FROM osm_motorways
                UNION ALL
                         SELECT osm_mainroads.osm_id,
                            osm_mainroads.type,
                            osm_mainroads.geometry::geometry(LineString, 900913) AS geometry,
                            osm_mainroads.name,
                            osm_mainroads.ref,
                            osm_mainroads.int_ref,
                            osm_mainroads.bridge,
                            osm_mainroads.tunnel,
                            osm_mainroads.oneway,
                            osm_mainroads.layer,
                            osm_mainroads.z_order,
                            osm_mainroads.access,
                            NULL::text AS service,
                            NULL::text AS usage,
                            'mainroads'::text AS class
                           FROM osm_mainroads)
        UNION ALL
                 SELECT osm_minorroads.osm_id,
                    osm_minorroads.type,
                    osm_minorroads.geometry::geometry(LineString, 900913) AS geometry,
                    osm_minorroads.name,
                    osm_minorroads.ref,
                    osm_minorroads.int_ref,
                    osm_minorroads.bridge,
                    osm_minorroads.tunnel,
                    osm_minorroads.oneway,
                    osm_minorroads.layer,
                    osm_minorroads.z_order,
                    osm_minorroads.access,
                    NULL::text AS service,
                    NULL::text AS usage,
                    'minorroads'::text AS class
                   FROM osm_minorroads)
UNION ALL
         SELECT osm_railways.osm_id,
            osm_railways.type,
            osm_railways.geometry::geometry(LineString, 900913) AS geometry,
            osm_railways.name,
            NULL::character varying AS ref,
            NULL::character varying AS int_ref,
            osm_railways.bridge,
            osm_railways.tunnel,
            0 AS oneway,
            osm_railways.layer,
            osm_railways.z_order,
            NULL::character varying AS access,
            osm_railways.service,
            osm_railways.usage,
            'railways'::text AS class
           FROM osm_railways;


CREATE OR REPLACE VIEW osm_roads_gen0 AS 
        (         SELECT osm_railways_gen0.osm_id,
                    osm_railways_gen0.type,
                    osm_railways_gen0.geometry::geometry(LineString, 900913) AS geometry,
                    osm_railways_gen0.name,
                    NULL::character varying AS ref,
                    NULL::character varying AS int_ref,
                    osm_railways_gen0.bridge,
                    osm_railways_gen0.tunnel,
                    0 AS oneway,
                    osm_railways_gen0.z_order,
                    NULL::character varying AS access,
                    osm_railways_gen0.service,
                    osm_railways_gen0.usage,
                    'railways_gen1'::text AS class
                   FROM osm_railways_gen0
        UNION ALL
                 SELECT osm_mainroads_gen0.osm_id,
                    osm_mainroads_gen0.type,
                    osm_mainroads_gen0.geometry::geometry(LineString, 900913) AS geometry,
                    osm_mainroads_gen0.name,
                    osm_mainroads_gen0.ref,
                    osm_mainroads_gen0.int_ref,
                    osm_mainroads_gen0.bridge,
                    osm_mainroads_gen0.tunnel,
                    osm_mainroads_gen0.oneway,
                    osm_mainroads_gen0.z_order,
                    osm_mainroads_gen0.access,
                    NULL::character varying AS service,
                    NULL::character varying AS usage,
                    'mainroads_gen1'::text AS class
                   FROM osm_mainroads_gen0)
UNION ALL
         SELECT osm_motorways_gen0.osm_id,
            osm_motorways_gen0.type,
            osm_motorways_gen0.geometry::geometry(LineString, 900913) AS geometry,
            osm_motorways_gen0.name,
            osm_motorways_gen0.ref,
            osm_motorways_gen0.int_ref,
            osm_motorways_gen0.bridge,
            osm_motorways_gen0.tunnel,
            osm_motorways_gen0.oneway,
            osm_motorways_gen0.z_order,
            osm_motorways_gen0.access,
            NULL::character varying AS service,
            NULL::character varying AS usage,
            'motorways_gen1'::text AS class
           FROM osm_motorways_gen0;


CREATE OR REPLACE VIEW osm_roads_gen1 AS 
        (         SELECT osm_railways_gen1.osm_id,
                    osm_railways_gen1.type,
                    osm_railways_gen1.geometry::geometry(LineString, 900913) AS geometry,
                    osm_railways_gen1.name,
                    NULL::character varying AS ref,
                    NULL::character varying AS int_ref,
                    osm_railways_gen1.bridge,
                    osm_railways_gen1.tunnel,
                    0 AS oneway,
                    osm_railways_gen1.z_order,
                    NULL::character varying AS access,
                    osm_railways_gen1.service,
                    osm_railways_gen1.usage,
                    'railways'::text AS class
                   FROM osm_railways_gen1
        UNION ALL
                 SELECT osm_mainroads_gen1.osm_id,
                    osm_mainroads_gen1.type,
                    osm_mainroads_gen1.geometry::geometry(LineString, 900913) AS geometry,
                    osm_mainroads_gen1.name,
                    osm_mainroads_gen1.ref,
                    osm_mainroads_gen1.int_ref,
                    osm_mainroads_gen1.bridge,
                    osm_mainroads_gen1.tunnel,
                    osm_mainroads_gen1.oneway,
                    osm_mainroads_gen1.z_order,
                    osm_mainroads_gen1.access,
                    NULL::character varying AS service,
                    NULL::character varying AS usage,
                    'mainroads'::text AS class
                   FROM osm_mainroads_gen1)
UNION ALL
         SELECT osm_motorways_gen1.osm_id,
            osm_motorways_gen1.type,
            osm_motorways_gen1.geometry::geometry(LineString, 900913) AS geometry,
            osm_motorways_gen1.name,
            osm_motorways_gen1.ref,
            osm_motorways_gen1.int_ref,
            osm_motorways_gen1.bridge,
            osm_motorways_gen1.tunnel,
            osm_motorways_gen1.oneway,
            osm_motorways_gen1.z_order,
            osm_motorways_gen1.access,
            NULL::character varying AS service,
            NULL::character varying AS usage,
            'motorways'::text AS class
           FROM osm_motorways_gen1;