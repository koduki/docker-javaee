#!/bin/bash

#
# change dns
#
DNS_HOST=consulboot
DNS_IP=`grep ${DNS_HOST} /etc/hosts|awk '{print $1}'`
sed "s/172.17.42.1/${DNS_IP}/g" /etc/resolv.conf  > resolv.conf.tmp
\cp -f resolv.conf.tmp /etc/resolv.conf
rm -f resolv.conf.tmp

#
# run services
#
fluentd -c /etc/fluent/fluent.conf &
consul agent -data-dir=/tmp/consul -config-dir=/etc/consul/conf.d -join=consul.service.consul &
/opt/glassfish4/glassfish/bin/asadmin start-domain --verbose=true
