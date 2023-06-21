#!/bin/bash
ip route | grep -q '10.0.2.1' &&
	echo '{"text":"Connected","class":"connected","percentage":100}' ||
	echo '{"text":"Disconnected","class":"disconnected","percentage":0}'
