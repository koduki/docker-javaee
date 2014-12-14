#!/bin/bash

./asadmin --user admin --passwordfile=pwdfile -I false create-jvm-options "-javaagent\:/opt/jolokia/jolokia-jvm-1.2.3-agent.jar=port=8778,host=localhost"
