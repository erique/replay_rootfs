#!/bin/bash

# run as "./docker.sh ./build.sh" or some such..

docker run -v $PWD:/host -w /host -e TERM=$TERM -it --rm fpgaarcade/replay-rootfs:latest /bin/bash -c "$*"
