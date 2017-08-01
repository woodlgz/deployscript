#!/bin/bash

source service_host.sh

for server in $service_list ;do s=`eval echo \\$$server`; echo $server; time curl "http://$s:20007/jt.html"; done

