#! /bin/bash
ps -ax | grep -v grep | grep fake_sensor.py | awk '{ print $1 }'| \
	while read pid; do kill -9 $pid; done
