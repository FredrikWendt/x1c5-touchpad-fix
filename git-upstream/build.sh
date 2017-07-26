#!/usr/bin/env bash

START=$(date -Iminutes)
TIME=$(date +%s)
IMAGE=git-upstream-kernel-build
CONTAINER=kernel-build-$TIME

echo "Build starting at $START"

if [ ! -f kernel-config ] ; then
	CONFIG=/boot/config-$(uname -r)
	echo "Copying kernel build config from $CONFIG"
	cp $CONFIG kernel-config
else
	echo "Using the kernel-config file already there"
fi

docker build --no-cache -t $IMAGE .

END=$(date -Iminutes)

echo "Build completed: from $START to $END"

trap "docker rm $CONTAINER" EXIT
FILES=$(docker run --name $CONTAINER $IMAGE find .. -name \*.deb | cut -d '/' -f 2-)

for FILE in $FILES ; do
	if [ ! -d build ] ; then
		mkdir -p build
	fi
	echo "Copying $FILE"
	docker cp $CONTAINER:/data/$FILE build/
done
