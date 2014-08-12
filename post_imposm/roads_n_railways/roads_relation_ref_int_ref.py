#!/usr/bin/env python

from imposm.parser import OSMParser

# simple class that handles the parsed OSM data.
class HighwayCounter(object):
  nb_highways = 0
  nb_relations = 0
  nb_route_relations = 0

  # def ways(self, ways):
  #   # callback method for ways
  #   for osmid, tags, refs in ways:
  #     if 'highway' in tags:
  #       self.nb_highways += 1

  def relations(self, relations):
    # callback method for relations
    for osmid, tags, members in relations:
      # print osmid, tags
      self.nb_relations += 1
      if ('type' in tags) and (tags['type'] == 'route') and ('route' in tags) and (tags['route'] == 'road'):
      # if ('ref' in tags):
        print osmid, tags.get('name'), tags.get('ref'), tags.get('network'), len(members)
        # if tags.get('ref') == "E 46":
        #   print tags
        self.nb_route_relations += 1

# instantiate counter and parser and start parsing
counter = HighwayCounter()
# p = OSMParser(concurrency=4, ways_callback=counter.ways, relations_callback=counter.relations)
p = OSMParser(concurrency=4, relations_callback=counter.relations)
p.parse('/home/benjamin/imposm/pbf/champagne-ardenne-latest.osm.pbf')


# done
print counter.nb_highways
print counter.nb_relations
print counter.nb_route_relations