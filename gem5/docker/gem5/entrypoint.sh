#!/bin/bash

function handler() {
	echo "SIGTERM caught, shutting down gem5"
	exit 0
}

trap handler TERM;

sleep infinity &
wait;