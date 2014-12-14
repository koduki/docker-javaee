#!/bin/bash

yum groupinstall -y "Development Tools"
yum install -y ruby-devel
gem install fluentd --no-ri --no-rdoc
gem install fluent-plugin-jvmwatcher --no-ri --no-rdoc

mkdir /var/lib/fluent/
chmod a+w /var/lib/fluent/
