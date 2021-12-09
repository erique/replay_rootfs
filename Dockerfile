# docker build -t replay-rootfs .
# docker run -it --rm replay-rootfs du -sch /root
# docker images
# docker tag <tag> fpgaarcade/replay-rootfs:latest
# docker push fpgaarcade/replay-rootfs:latest

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update                                                        && \
    apt-get install -y mtools sed make binutils build-essential gcc g++      \
                       bash patch gzip bzip2 perl tar cpio unzip rsync bc    \
                       file wget python3 bzr cvs git mercurial subversion    \
                       graphviz                                           && \
    apt-get autoremove -y                                                 && \
    apt-get clean                                                         && \
                                                                             \
    cd /home                                                              && \
    git clone --recurse-submodules                                           \
                https://github.com/FPGAArcade/replay_rootfs.git           && \
    ./replay_rootfs/build.sh                                              && \
    rm -rf replay_rootfs                                                  && \
                                                                             \
    echo Done.
