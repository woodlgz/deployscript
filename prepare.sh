#!/bin/bash

echo "copy binary from t1 ..."
mkdir -p pack
copyfrom t1 /root/new_core/deploy/ADCore.v1.tar.gz pack/
copyfrom t1 /root/new_core/deploy/libboost.tar.gz pack/
copyfrom t1 /root/new_core/deploy/deploy_new.sh pack/
copyfrom t1 /root/new_core/deploy/deploy.status pack/

for server in t2 t3 t4 t5 ;
do
	echo "deploy binary to $server ...."
	copyto $server pack/ADCore.v1.tar.gz /root/new_core/deploy/
	copyto $server pack/libboost.tar.gz /root/new_core/deploy/
	copyto $server pack/deploy_new.sh /root/new_core/deploy/
done
