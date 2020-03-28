#!/bin/bash

kubectl create ns sample-project

for MICROSERVICE in api-gateway microservice-users microservice-addresses
do
  URL="https://raw.githubusercontent.com/restqa/sample-project/master/$MICROSERVICE/manifest.yml"
  echo $URL
  kubectl create -f $URL -n sample-project
done
