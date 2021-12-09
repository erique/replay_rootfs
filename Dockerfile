# docker build -t replay-rootfs .
# docker run -it --rm replay-rootfs bash -c "du -sch \$HOME/.buildroot-cache/*"
# docker images
# docker tag <tag> fpgaarcade/replay-rootfs:latest
# docker push fpgaarcade/replay-rootfs:latest

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update                                                        && \
    apt-get install -y mtools sed make binutils build-essential gcc g++      \
                       bash patch gzip bzip2 perl tar cpio unzip rsync bc    \
                       file wget python python3 pip bzr cvs git mercurial    \
                       subversion graphviz libncurses-dev curl            && \
    apt-get autoremove -y                                                 && \
    apt-get clean
    
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && \
    python2 get-pip.py                                                    && \
    rm get-pip.py                                                         && \
    python -m pip install matplotlib numpy

RUN useradd -ms /bin/bash rootfs
USER rootfs
WORKDIR /home/rootfs

RUN git clone --recurse-submodules                                           \
                https://github.com/FPGAArcade/replay_rootfs.git           && \
    ./replay_rootfs/build.sh                                              && \
    rm -rf replay_rootfs                                                  && \
                                                                             \
    echo Done.
