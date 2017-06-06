FROM ubuntu:17.04

RUN sed -i \
	-e "s/archive/se.archive/" \
	-e "s/# deb-src/deb-src/" \
	-e "/partner/d" \
	/etc/apt/sources.list
RUN apt-get update -qy 
RUN apt-get upgrade -qy
RUN apt-get install -qy build-essential fakeroot devscripts
RUN mkdir -p /data
WORKDIR /data
ENV _OUR_PACKAGE_NAME=linux-image-extra-4.10.0-19-generic
RUN apt-get source $_OUR_PACKAGE_NAME
RUN apt-get build-dep -qy $_OUR_PACKAGE_NAME
COPY len0073-linux-4.10.0.patch /
RUN cd linux* && patch -p1 < /len0073-linux-4.10.0.patch
RUN cd linux* && debuild -b -uc -us
