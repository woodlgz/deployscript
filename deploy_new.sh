#!/bin/bash


function stopTimeoutGuard(){
	for pid in `ps -ef|grep "timeout.sh" |awk '{printf("%s\n",$2)}'`
	do
		kill -9 $pid 2>/dev/null
	done
}

function stopOldService(){
	local service_dir=$1
	local old_cwd=`pwd`
	cd $service_dir/ADCore/
	./run.sh stop
	stopTimeoutGuard
	echo "stoping service of ${service_dir}..."
	sleep 5
	cd $old_cwd
}


function startNewService(){
	local service_dir=$1
	local old_cwd=`pwd`
	mv $service_dir/ADCore $service_dir/ADCore.$RANDOM
	tar -vxf ADCore.v1.tar.gz -C $service_dir/
	cd $service_dir/ADCore/
	./run.sh
	nohup ./timeout.sh >./timeout.txt 2>&1 &
	echo "service start!!"
	cd $old_cwd
}

is_service0=`cat deploy.status`
new_service_dir=Service0
old_service_dir=Service1
status=0
if [[ $is_service0 == 0 ]];
then
	new_service_dir=Service1
	old_service_dir=Service0
	status=1
else
	new_service_dir=Service0
	old_service_dir=Service1
	status=0
fi

stopOldService $old_service_dir
startNewService $new_service_dir
echo $status >deploy.status
