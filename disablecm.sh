#!/bin/bash

source /usr/local/bin/service_host.sh

for server in $service_list;
do
   echo $server
   remoteexec $server "sed -i 's/disable_cm yes/disable_cm no/g' /opt/adservice/conf/nginx.conf"; 
   remoteexec $server "docker stop adselect adservice"
   remoteexec $server "docker start adselect adservice"
done
