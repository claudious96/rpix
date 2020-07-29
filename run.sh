#!/bin/bash

set -ex

sudo apt-get -y install autoconf automake bison build-essential \
	diffutils flex gawk git gperf help2man make patch libncurses5-dev \
	texinfo wget xz-utils python python3 unzip libtool libtool-bin \
	aria2

aria2c -x 8 https://sourceforge.net/projects/raspberry-pi-cross-compilers/files/Raspberry%20Pi%20GCC%20Cross-Compiler%20Toolchains/Buster/GCC%2010.1.0/Raspberry%20Pi%203A%2B%2C%203B%2B%2C%204/cross-gcc-10.1.0-pi_3%2B.tar.gz/download
tar axf cross-gcc-10.1.0-pi_3+.tar.gz
sudo mkdir -p /opt
sudo mv cross-pi-gcc-10.1.0-2 /opt  

#wtf
temp="${PATH%\"}"
temp="${temp#\"}"
export PATH="${temp}:/opt/cross-pi-gcc-10.1.0-2/bin/"

aria2c -x 8 http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.24.0.tar.bz2 && \
	tar axf crosstool-ng-1.24.0.tar.bz2 && \
	pushd crosstool-ng-1.24.0 && \
	./configure && \
	make -j4 && \
	sudo make install && \
	popd

ct-ng build

tar acf x-tools.tar.xz ~/x-tools
