#!/bin/bash

if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi

export DEVOPS=$1
echo "env var: "$DEVOPS
rm index.html
echo "<h1>Hello $DEVOPS</h1>" >> $(pwd)/index.html



