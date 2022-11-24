#!/bin/sh

NAME=blog
IMAGE_NAME=heenluy/$NAME
VERSION=0.0.1

echo "[DEPLOY] Building the project (1/4)"
mvn package && java -jar target/$NAME-$VERSION.jar

echo "[DEPLOY] Creating docker image from JAR file (2/4)"
docker build -t $IMAGE_NAME .

echo "[DEPLOY] Running docker image '$IMAGE_NAME' (3/4)"
docker run -p 8080:8080 $IMAGE_NAME
