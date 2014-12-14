#!/bin/bash

USER_NAME=docker
PASSWORD=password
URL='jdbc\:mysql\://db\:3306/testdb'
RESOURCE_NAME=jdbc/testdb
POOL_NAME=MySQLPool
DATASOURCE_NAME=com.mysql.jdbc.jdbc2.optional.MysqlDataSource

./asadmin --user admin --passwordfile=pwdfile -I false create-jdbc-connection-pool \
          --datasourceclassname ${DATASOURCE_NAME} --restype javax.sql.DataSource \
          --property user=${USER_NAME}:password=${PASSWORD}:url=${URL} ${POOL_NAME}

./asadmin --user admin --passwordfile=pwdfile -I false create-jdbc-resource \
          --connectionpoolid ${POOL_NAME} ${RESOURCE_NAME}
