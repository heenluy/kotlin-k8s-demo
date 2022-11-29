#!/bin/sh

PROJECT_NAME=demo-blog
IMAGE_NAME=kotlin-k8s-demo
VERSION=0.0.1
JAR_FILE=target/*.jar
YES=yes

[ ! -e $JAR_FILE ] && { echo "[DEPLOY] Building the project"; bash mvnw package; }

[ -e $JAR_FILE ] && { echo "[DEPLOY] Creating docker image from JAR file"; docker build -t $IMAGE_NAME .; } ||
{ echo "[DEPLOY] Error: file '$PROJECT_NAME-$VERSION.jar' not found"; exit; }

echo "[DEPLOY] Starting minikube"
minikube version
if [ $? != 0 ]; then 
echo "[DEPLOY] Error: it is necessary to have 'minikube' installed!"
exit
fi

#minikube start --driver=docker

echo "[DEPLOY] Creating the deployment"
kubectl version
if [ $? != 0 ]; then
echo "[DEPLOY] Error: it is necessary to have 'kubectl' installed!"
exit
fi

kubectl create -f kube/blog-deployment.yaml

echo "[DEPLOY] Creating a service for the deployment"
kubectl create -f kube/blog-service.yaml

read -p 'The app will run in your default browser, is that ok? (yes/no): ' USER_ANSWER
if [ "$USER_ANSWER" = "$YES" ]; then
minikube service $PROJECT_NAME
else
exit
fi

# LEMBRE-SE DO CHMOD
