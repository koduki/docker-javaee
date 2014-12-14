#!/bin/bash

# install jar
mkdir /opt/jolokia
cd /opt/jolokia
wget https://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/1.2.3/jolokia-jvm-1.2.3-agent.jar

# install fluent plugin
gem install rake bundler
cd /tmp
wget https://github.com/lburgazzoli/lb-fluent-plugin-jolokia/archive/master.zip
unzip master.zip

cd lb-fluent-plugin-jolokia-master/
rake
gem install pkg/fluent-plugin-jolokia-0.0.1.gem
cd .. 
rm -rf master.zip
rm -rf lb-fluent-plugin-jolokia-master