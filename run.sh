#!/usr/bin/env bash

set -e

echo "Starting Graphhopper process"

DEFAULT_JAVA_OPTS="-server -Xconcurrentio -Xmx1g -Xms1g -XX:+UseG1GC -XX:MetaspaceSize=100M -Ddw.server.applicationConnectors[0].bindHost=0.0.0.0 -Ddw.server.applicationConnectors[0].port=8989"
export JAVA_OPTS="${JAVA_OPTIONS:-$DEFAULT_JAVA_OPTS}"

echo JAVA_OPTIONS \"$JAVA_OPTS\"

osm_latest_filename='planet-latest.osm.pbf'
if [ ! -f /data/$osm_latest_filename ] ; then
	echo "Downloading latest OSM file"
	osm_filename=planet_$(date '+%Y-%m-%d').osm.pbf
	test -f $osm_filename || wget --quiet https://planet.osm.org/pbf/$osm_latest_filename -O /data/$osm_filename
	ln -s /data/$osm_filename /data/$osm_latest_filename
else
	echo "Using current OSM file $(ls /data/planet_*)"
fi

echo "Launch graphhopper"
/home/graphhopper/graphhopper.sh web /data/$osm_latest_filename
