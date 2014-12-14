FROM koduki/centos7
MAINTAINER koduki

# Install Fluentd
ADD resources/install-fluentd.sh /tmp/
RUN /tmp/install-fluentd.sh
ADD resources/fluent.conf /etc/fluent/fluent.conf

# Install Consul
ADD resources/install-consul.sh /tmp/
RUN /tmp/install-consul.sh
ADD resources/consul.d/fluent.json /etc/consul/conf.d/

# Fluentd port
EXPOSE 24224 

USER root

ADD resources/run.sh /tmp/
ENTRYPOINT /tmp/run.sh
