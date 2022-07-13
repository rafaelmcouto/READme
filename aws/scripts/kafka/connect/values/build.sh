#!/bin/bash

echo "#########################################################################################"
echo "#                           STATING BUILD IMAGE KAFKA CONNECT                           #"
echo "#########################################################################################"

echo "===========>  Login ECR"
aws ecr get-login-password --region ${REGION} | docker login  --username AWS  --password-stdin ${REGISTRY}

echo "===========>  Building Image Kafka Connect"
docker build -t ${IMAGE}:${TAG} .

echo "===========>  Tagging Image Kafka Connect"
docker image tag ${IMAGE}:${TAG} ${REGISTRY}:${TAG}
docker images

echo "===========>  Pushing Image Kafka Connect in the ECR"
docker image push ${REGISTRY}:${TAG}

echo "#########################################################################################"
echo "#                          FINISHING BUILD IMAGE KAFKA CONNECT                          #"
echo "#########################################################################################"
