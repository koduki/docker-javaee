#!/bin/sh

URL=http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.rpm
HEADER="Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"

curl -L --header "${HEADER}" ${URL} -o tmp.rpm
yum -y install tmp.rpm
rm tmp.rpm

alternatives --install /usr/bin/java java /usr/java/default/bin/java 180020
alternatives --install /usr/bin/javac javac /usr/java/default/bin/javac 180020
