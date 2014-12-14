#!/bin/bash

URL=http://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts/2.0.2/gatling-charts-highcharts-2.0.2-bundle.zip

cd /tmp

wget ${URL}
unzip gatling-charts-highcharts-2.0.2-bundle.zip
rm    gatling-charts-highcharts-2.0.2-bundle.zip

mv gatling-charts-highcharts-2.0.2 /opt/gatling2
rm -rf /opt/gatling2/user-files/simulations/computerdatabase/
