#!/bin/bash

NAMESPACE=sample-project-olivierodo
kubectl create ns $NAMESPACE

for MICROSERVICE in api-gateway microservice-users microservice-addresses
do
  URL="https://raw.githubusercontent.com/restqa/sample-project/master/$MICROSERVICE/manifest.yml"
  echo $URL
  kubectl create -f $URL -n $NAMESPACE
done
