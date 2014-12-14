FROM koduki/centos7
MAINTAINER koduki

# Install Build tools
RUN yum -y install maven
ADD resources/pom.xml /tmp/

# Install Oracle JDK
ADD resources/install-oracle-jdk8.sh /tmp/
RUN /tmp/install-oracle-jdk8.sh

# Install Fluentd
ADD resources/install-fluentd.sh /tmp/
RUN /tmp/install-fluentd.sh

# Install Consul 
ADD resources/install-consul.sh /tmp/
RUN /tmp/install-consul.sh
ADD resources/consul.d/web.json /etc/consul/conf.d/

# Install Jolokia
ADD resources/install-jolokia.sh /tmp/
RUN /tmp/install-jolokia.sh

# Configurate Fluentd
USER root
ADD resources/fluent.conf /etc/fluent/fluent.conf
