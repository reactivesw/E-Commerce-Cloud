#!/bin/bash

set -e

#docker build -t gcr.io/${PROJECT_NAME_STG}/${DOCKER_IMAGE_NAME}:$TRAVIS_COMMIT .

echo '==========decode gcloud service key=========================='

echo $GCLOUD_SERVICE_KEY_STG | base64 --decode -i > ${HOME}/gcloud-service-key.json

echo '==========finish decode gcloud service key==================='

echo '==========gcloud auth accout config=========================='

gcloud auth activate-service-account --key-file ${HOME}/gcloud-service-key.json

echo '==========finish gcloud auth accout config==================='

echo '==============gcloud config project=========================='
echo $PROJECT_NAME_STG
gcloud --quiet config set project $PROJECT_NAME_STG
echo '==============finish gcloud config project==================='

echo '==============gcloud config container cluster================'
echo $CLUSTER_NAME_STG
gcloud --quiet config set container/cluster $CLUSTER_NAME_STG
echo '==============finish config container cluster================'

echo '==============gcloud config compute zone====================='
echo ${CLOUDSDK_COMPUTE_ZONE}
gcloud --quiet config set compute/zone ${CLOUDSDK_COMPUTE_ZONE}
echo '==============finish gcloud config compute zone=============='

echo '==============gcloud config cluster credentials=============='
echo $CLUSTER_NAME_STG
gcloud --quiet container clusters get-credentials $CLUSTER_NAME_STG
echo '========finish gcloud container cluster credentials=========='

#gcloud docker push gcr.io/${PROJECT_NAME_STG}/${DOCKER_IMAGE_NAME}

#yes | gcloud beta container images add-tag gcr.io/${PROJECT_NAME_STG}/${DOCKER_IMAGE_NAME}:$TRAVIS_COMMIT gcr.io/${PROJECT_NAME_STG}/${DOCKER_IMAGE_NAME}:latest

echo '==============kubectl config view============================'
kubectl config view
echo '============================================================='

echo '==============kubectl config current-context================='
kubectl config current-context
echo '============================================================='

echo '==============kubectl create yaml============================'
kubectl create -f ./category/k8s.yaml
echo '============================================================='