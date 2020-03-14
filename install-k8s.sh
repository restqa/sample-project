#!/bin/bash

kubectl create ns sample-project

for MICROSERVICE in 1-api-gateway 2-microservice-users 3-microservice-addresses
do
  URL="https://raw.githubusercontent.com/restqa/sample-project/master/$MICROSERVICE/manifest.yml"
  echo $URL
  kubectl create -f $URL -n sample-project
done
