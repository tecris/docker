#!/bin/sh

. ./imageName

docker run --name tomcat7 -d -p 8080:8080 -p 24:22 $IMAGE_NAME
