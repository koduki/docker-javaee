FROM koduki/javaee-managed
MAINTAINER koduki

# Install GlassFish
ADD resources/install-glassfish.sh /tmp/
RUN /tmp/install-glassfish.sh

# Configurate Maven
USER glassfish
RUN cd /tmp && mvn install

#
# Configurate GlassFish
#

# set glassfish user and workdir
#USER glassfish
USER glassfish
WORKDIR /opt/glassfish4/bin

# User: admin / Pass: glassfish
RUN echo "admin;{SSHA256}80e0NeB6XBWXsIPa7pT54D9JZ5DR5hGQV1kN1OAsgJePNXY6Pl0EIw==;asadmin" > /opt/glassfish4/glassfish/domains/domain1/config/admin-keyfile
RUN echo "AS_ADMIN_PASSWORD=glassfish" > pwdfile

# Default to admin/glassfish as user/pass
RUN \
  ./asadmin start-domain && \
  ./asadmin --user admin --passwordfile pwdfile enable-secure-admin && \
  ./asadmin stop-domain

# Server Confirations
ADD resources/glassfish-jdbc.sh /tmp/
ADD resources/glassfish-jolokia.sh /tmp/
ADD resources/glassfish-gc.sh /tmp/
RUN ./asadmin start-domain && \
    /tmp/glassfish-jdbc.sh && \
    /tmp/glassfish-jolokia.sh && \
    /tmp/glassfish-gc.sh && \
   ./asadmin stop-domain

# Deploy Application
ADD resources/glassfish-deploy.sh /tmp/
RUN /tmp/glassfish-deploy.sh

# default glassfish ports
EXPOSE 4848 8080 8181

#
# RUN GlassFish and Fluentd
#
USER root
ADD resources/run.sh /tmp/run.sh
CMD /tmp/run.sh
