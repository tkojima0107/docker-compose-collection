#!/bin/bash

function handler() {
	echo "SIGTERM caught, shutting down riscv_devel"
	exit 0
}

trap handler TERM;

sleep infinity &
wait;