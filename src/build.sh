#!/bin/sh

docker build \
    --build-arg user=$USER \
    --build-arg uid=$(id -u) \
    --build-arg gid=$(id -g) \
    -t docker_ros \
    .
