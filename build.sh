#!/bin/bash

REPO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $REPO_ROOT

DE10=${REPO_ROOT}/de10

make -C buildroot O=${REPO_ROOT}/out clean
make -C buildroot O=${REPO_ROOT}/out defconfig BR2_DEFCONFIG=${DE10}/buildroot/terasic_de10nano_cyclone5_replay_defconfig
make -C buildroot O=${REPO_ROOT}/out
