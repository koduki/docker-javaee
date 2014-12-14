#!/bin/bash

wget https://dl.bintray.com/mitchellh/consul/0.4.1_linux_amd64.zip && \
unzip 0.4.1_linux_amd64.zip && \
mv consul /usr/local/bin && \
rm -f 0.4.1_linux_amd64.zip

mkdir -p /etc/consul/conf.d
