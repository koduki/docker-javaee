#!/bin/bash

GLASSFISH_URL=http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip
MYSQL_DRIVER_URL=http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.34.zip

# install glassfish
cd /opt/
wget -qO- -O tmp.zip $GLASSFISH_URL
unzip tmp.zip
rm tmp.zip 

# install mysql driver
cd /tmp/
wget $MYSQL_DRIVER_URL
unzip mysql-connector-java-5.1.34.zip
cp mysql-connector-java-5.1.34/mysql-connector-java-5.1.34-bin.jar /opt/glassfish4/glassfish/domains/domain1/lib/
rm -rf mysql-connector-java-5.1.34/
rm mysql-connector-java-5.1.34.zip

# change permission
useradd glassfish
chown -R glassfish:glassfish /opt/glassfish4/
