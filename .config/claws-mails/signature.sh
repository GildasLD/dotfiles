#!/bin/bash

key=$(head -c 12 /dev/urandom | base64)

cat << EOL

$key
EOL
