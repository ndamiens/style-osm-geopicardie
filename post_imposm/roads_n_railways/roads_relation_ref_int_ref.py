#!/usr/bin/env python
# -*- coding: utf-8 -*-

from imposm.parser import OSMParser

# simple class that handles the parsed OSM data.
class RelationParser(object):
  nb_route_relations = 0

  relations_to_store = []

  def relations(self, relations):
    # callback method for relations
    for current_relation in relations:
      osm_id = current_relation[0]
      tags = current_relation[1]
      members = current_relation[2]
    # for osmid, tags, members in relations:
      if ('type' in tags) and (tags['type'] == 'route') and ('route' in tags) and (tags['route'] == 'road'):
        self.nb_route_relations += 1
        self.relations_to_store.append(current_relation)

# instantiate counter and parser and start parsing
parser = RelationParser()
p = OSMParser(concurrency=4, relations_callback=parser.relations)
p.parse('/home/benjamin/imposm/pbf/champagne-ardenne-latest.osm.pbf')


# done
print u"-- Nombre de relations traitées : {}".format(parser.nb_route_relations)

print u"""-- Suppression des tables si elles existent déjà
DROP TABLE if exists osm_road_relations;
DROP TABLE if exists osm_road_relations_members;
"""

print u"""-- Création de la table osm_road_relations
CREATE TABLE osm_road_relations
(
  osm_id bigint,
  type character varying(255),
  route character varying(255),
  network character varying(255),
  ref character varying(255),
  name character varying(1024)
)
WITH (
  OIDS=FALSE
);
"""

print u"""-- Création de la table osm_road_relations_members
CREATE TABLE osm_road_relations_members
(
  osm_id bigint,
  member_osm_id bigint,
  type character varying(255),
  role character varying(255)
)
WITH (
  OIDS=FALSE
);
"""

osm_road_relations_strings = []
osm_road_relations_members_strings = []

for relation in parser.relations_to_store:
  osm_id = relation[0]
  tags = relation[1]
  members = relation[2]

  r_type = tags.get('type')
  if r_type != None:
    r_type = "'" + r_type + "'"
  else:
    r_type = u'NULL'

  r_route = tags.get('route')
  if r_route != None:
    r_route = "'" + r_route + "'"
  else:
    r_route = u'NULL'

  r_network = tags.get('network')
  if r_network != None:
    r_network = "'" + r_network + "'"
  else:
    r_network = u'NULL'

  r_ref = tags.get('ref')
  if r_ref != None:
    r_ref = "'" + r_ref + "'"
  else:
    r_ref = u'NULL'

  r_name = tags.get('name')
  if r_name != None:
    r_name = r_name.replace("'", "''")
    r_name = "'" + r_name + "'"
  else:
    r_name = u'NULL'

  osm_road_relations_strings.append(u"  ({0}, {1}, {2}, {3}, {4}, {5})".format(osm_id, r_type, r_route, r_network, r_ref, r_name))

  for member in members[:4]:
    # member_osm_id = 
    osm_road_relations_members_strings.append(u"  ({0}, {1}, {2}, {3})".format(osm_id, member[0], "'" + member[1] + "'", "'" + member[2] + "'"))

print u"-- Insertion des enregistrements dans la table osm_road_relations"
print u"INSERT INTO osm_road_relations (osm_id, type, route, network, ref, name) VALUES"
print u",\n".join(osm_road_relations_strings)
print u";"
print u"\n"

print u"-- Insertion des enregistrements dans la table osm_road_relations_members"
print u"INSERT INTO osm_road_relations_members (osm_id, member_osm_id, type, role) VALUES"
print u",\n".join(osm_road_relations_members_strings)
print u";"
print u"\n"
