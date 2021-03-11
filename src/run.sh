#!/bin/sh

docker run \
    -e DISPLAY=unix$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
    -v $HOME/Documents/ROS/SRB/src:$HOME/catkin_ws/src \
    -e XAUTHORITY=/tmp/.docker.xauth \
    -v /dev/SlabSRB:/dev/SlabSRB \
    --privileged \
    -it --name docker_ros docker_ros
    # use GPU
    # --env="QT_X11_NO_MITSHM=1" \

