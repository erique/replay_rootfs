#!/bin/bash

# run as "./docker.sh ./build.sh" or some such..

docker run -v $PWD:/home/rootfs/replay-rootfs -w /home/rootfs/replay-rootfs -e TERM=$TERM -h $(hostname)-docker -it --rm fpgaarcade/replay-rootfs:latest /bin/bash -c "$*"
