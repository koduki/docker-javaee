#!/bin/bash

WORKDIR=/tmp

cd $WORKDIR

# Get test app.
wget -O jst.zip https://github.com/koduki/javaee-benchmark-suite/archive/master.zip
unzip jst.zip

# Build
cd javaee-benchmark-suite-master/apps/javaee-simple-tester/
mvn package

# Deploy
cp target/javaee-simple-tester-1.0-SNAPSHOT.war /tmp/
cp /tmp/javaee-simple-tester-1.0-SNAPSHOT.war /opt/glassfish4/glassfish/domains/domain1/autodeploy/
