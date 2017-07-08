FROM ubuntu:17.04

RUN sed -i \
	-e "s/archive/se.archive/" \
	-e "s/# deb-src/deb-src/" \
	-e "/partner/d" \
	/etc/apt/sources.list
RUN apt-get update -qy 
RUN apt-get upgrade -qy
RUN apt-get install -qy build-essential fakeroot devscripts
RUN apt-get install -qy git kernel-package libncurses5-dev libssl-dev ccache

RUN mkdir -p /data
WORKDIR /data

RUN git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
WORKDIR /data/linux

COPY len0073-20170628.patch /len0073.patch
RUN patch -p1 -l < /len0073.patch
COPY kernel-config .config

RUN yes '' | make oldconfig
RUN scripts/config --disable DEBUG_INFO
RUN echo "CONFIG_RMI4_SMB=m" >> .config
RUN make clean
RUN make -j $(getconf _NPROCESSORS_ONLN) deb-pkg LOCALVERSION=-custom
