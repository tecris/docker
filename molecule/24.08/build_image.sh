#!/bin/bash

IMAGE_TAG=$(date +"%y.%m.%d")
IMAGE_NAME=org.tecris/molecule6:${IMAGE_TAG}

docker buildx build \
    --no-cache \
    --progress=plain \
    --load \
    -t ${IMAGE_NAME} \
    -f Dockerfile \
    ./
