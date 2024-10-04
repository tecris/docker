#!/bin/bash

TAG=23.05.16
./build_ssh_base_image.sh ${TAG}

docker volume create --name volume_zero
docker run -v volume_zero:/keys org.tecris/ssh:${TAG} rm -rf /keys/*

docker run -v volume_zero:/keys org.tecris/ssh:${TAG} ssh-keygen -t ed25519 -f /keys/user_ca -C "CA key for user" -q -N ""
docker run -v volume_zero:/keys org.tecris/ssh:${TAG} ssh-keygen -t ed25519 -f /keys/host_ca -C "CA key for host" -q -N ""
docker run -v volume_zero:/keys org.tecris/ssh:${TAG} ls -l /keys

docker run --name volume_helper -d -v volume_zero:/keys busybox:1.37 true
docker cp volume_helper:/keys .

./build_host_image.sh ${TAG}
./build_user_image.sh ${TAG}

docker compose up -d
