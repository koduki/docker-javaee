#!/bin/bash

./asadmin --user admin --passwordfile=pwdfile -I false create-jvm-options --target server "-agentlib\:heapstats"
./asadmin --user admin --passwordfile=pwdfile -I false create-jvm-options --target server "-XX\:+UseCompressedOops"
