#!/usr/bin/env bash

START=$(date -Iminutes)

echo "Build starting at $START"

if [ ! -f kernel-config ] ; then
	CONFIG=/boot/config-$(uname -r)
	echo "Copying kernel build config from $CONFIG"
	cp $CONFIG kernel-config
else
	echo "Using the kernel-config file already there"
fi

docker build --no-cache -t git-upstream-kernel-build .

END=$(date -Iminutes)

echo "Build completed: from $START to $END"

cat <<EOF
docker cp  these files from the container:
linux-firmware-image-4.12.0-rc7-custom_4.12.0-rc7-custom-1_amd64.deb
linux-headers-4.12.0-rc7-custom_4.12.0-rc7-custom-1_amd64.deb
linux-image-4.12.0-rc7-custom_4.12.0-rc7-custom-1_amd64.deb
linux-libc-dev_4.12.0-rc7-custom-1_amd64.deb
EOF
