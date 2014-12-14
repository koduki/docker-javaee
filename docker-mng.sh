#!/bin/bash

NAME=docker-javaee

function dockers_up {
  # check proc
  if [ -e ${NAME}.proc ]; then
    echo "Exist ${NAME}.proc. ${NAME} are maybe running. Please 'sudo ./docker-mng.sh stop'."
    exit 1
  fi

  # remove old images
  echo 'docker rm consulboot'
  docker rm consulboot

  echo 'docker rm db'
  docker rm db

  # run consul
  echo "start consul"
  docker run \
    --name consulboot \
    -h consulnode1 \
    -p 8400:8400 \
    -p 8500:8500 \
    -p 172.17.42.1:53:53/udp \
    -d progrium/consul -server -bootstrap-expect 3 >> ${NAME}.proc

  JOIN_IP="$(docker inspect -f '{{.NetworkSettings.IPAddress}}' consulboot)"
  docker run -d -h consulnode2 progrium/consul -server -join $JOIN_IP >> ${NAME}.proc
  docker run -d -h consulnode3 progrium/consul -server -join $JOIN_IP >> ${NAME}.proc
  echo "booted consul"
  
  echo 'waiting 3 seconds...'
  sleep 3s  

  # run mysql
  echo "start mysql"
  docker run \
    --name db \
    -e MYSQL_USER=docker \
    -e MYSQL_PASSWORD=password \
    -e MYSQL_ROOT_PASSWORD=password \
    -e MYSQL_DATABASE=testdb \
    -d mysql >> ${NAME}.proc
  echo "booted mysql"
 
  # run  koduki/jst-mng
  sleep 1s  
  echo "start mng-server"
  docker run \
    --link=consulboot:consulboot \
    -p 8000:8000 \
    -d koduki/javaee-manage >> ${NAME}.proc
  echo "booted mng-server"

  # run  koduki/jst-app-glassfish
  sleep 1s  
  echo "start app-server"
  docker run \
    --link=consulboot:consulboot \
    --link=db:db \
    -p 8080:8080 \
    -p 4848:4848 \
    -d koduki/glassfish-managed >> ${NAME}.proc
  echo "booted app-server"
}

function dockers_stop {
  echo 'stop docker'
  cat ${NAME}.proc|xargs docker stop
  rm ${NAME}.proc
  echo 'finish'
}

function dokcer_help {
  echo "Usage: $CMDNAME [up|stop]" 1>&2
}

#
# main
#
CMDNAME=`basename $0`
if [ $# -ne 1 ]; then
  docker_help
  exit 1
elif [ $1 == 'up' ]; then
  dockers_up
elif [ $1 == 'stop' ]; then
  dockers_stop
else
  docker_help
  exit 1
fi
