#!/bin/bash

./asadmin --user admin --passwordfile=pwdfile -I false create-jvm-options --target server "-Xloggc\:../logs/gc.log"
./asadmin --user admin --passwordfile=pwdfile -I false create-jvm-options --target server "-XX\:+PrintGCDetails"
./asadmin --user admin --passwordfile=pwdfile -I false create-jvm-options --target server "-XX\:+PrintGCDateStamps"
