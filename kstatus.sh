#!/bin/bash
while true; do
	echo "--"
	if [ -z "$1" ]; then
		OUTPUT=$(minikube kubectl -- get cm,pods,services,rs,deployment -o wide)
	else
		OUTPUT=$(minikube kubectl -- get cm,pods,services,rs,deployment -o wide -n $1)
	fi
	clear
	echo "--"
	if [ -z "$1" ]; then
		echo "-- Recursos desplegados en el namespace por defecto"
	else
		echo "-- Recursos desplegados en el namespace $1"
	fi
	echo -n "-- "
	date
	echo "--"
	echo "$OUTPUT"
	sleep 5
done