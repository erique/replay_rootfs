#!/bin/bash

set -e

REPO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $REPO_ROOT

DE10=${REPO_ROOT}/de10

mkdir -p ${DE10}/overlay/usr/lib
cat > ${DE10}/overlay/usr/lib/os-release <<EOF 
NAME="FPGAArcade Replay for DE10-Nano"
VERSION=`date +%Y.%m.%d`
ID=replay
VERSION_ID=`git describe --tag --always --dirty`
BUILD_ID=`date +%Y.%m.%d`-g`git describe --tag --always --dirty`
PRETTY_NAME="FPGAArcade Replay for DE10-Nano `date +%Y.%m.%d`"
HOME_URL=`git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//'`
EOF

rm -rf ${REPO_ROOT}/out
make -C buildroot O=${REPO_ROOT}/out defconfig BR2_DEFCONFIG=${DE10}/buildroot/terasic_de10nano_cyclone5_replay_defconfig
make -C buildroot O=${REPO_ROOT}/out

mkdir -p ${REPO_ROOT}/image
cp out/target/etc/os-release ${REPO_ROOT}/image/
cp out/images/sdcard.img ${REPO_ROOT}/image/

mkdir -p ${REPO_ROOT}/update
cp out/target/etc/os-release ${REPO_ROOT}/update/
mcopy -sn -i out/images/boot.vfat ::* ${REPO_ROOT}/update/
