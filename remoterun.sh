#!/bin/bash

for server in t2 t3 t4 t5
do
	echo "remote install new service on ${server}...."
	remoteexec $server "cd new_core/deploy/ && ./deploy_new.sh"
done
