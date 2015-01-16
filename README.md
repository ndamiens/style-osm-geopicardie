style-osm-geopicardie
=====================

Objectif du projet :

Mettre en place une chaîne de production d'un fond cartographique basé sur 
OpenStreetMap et adapaté à un usage typique d'une plate-forme géographique 
régionale française publique telle que GéoPicardie.


Outils utilisés :
* Postgresql
* PostGIS
* imposm
* Mapnik
* TileMill
* MapProxy


Styles existants :
* bright : fond cartographique contrasté

Styles planifiés :
* fade : fond cartographique en demi-teintes
* grey : fond cartographique en niveaux de gris
* admin : limites administratives
* overhead : lignes électriques et éoliennes
* overlay : toponymes et réseau routier/ferré


Projections supportées :
* EPSG:2154 : Lambert 93
* EPSG:3857 : projection Google et al


Les fichiers de styles élaborés pour ce projet ont été largement inspirés par 
le projet OSM-Bright.