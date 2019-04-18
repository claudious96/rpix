#!/bin/bash

set -ex

sudo apt-get -y install autoconf automake bison build-essential \
	diffutils flex gawk git gperf help2man make patch libncurses5-dev \
	texinfo wget xz-utils python python3 unzip libtool libtool-bin \
	axel

axel -n 6 https://sourceforge.net/projects/raspberry-pi-cross-compilers/files/Raspberry%20Pi%20GCC%20Cross-Compilers/GCC%206.3.0/Raspberry%20Pi%202%2C%203/cross-gcc-6.3.0-pi_2-3.tar.gz
tar axf cross-gcc-6.3.0-pi_2-3.tar.gz
export PATH=$PATH:`pwd`/cross-pi-gcc-6.3.0-1/bin/

axel -n 5 http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.24.0.tar.bz2 && \
	tar axf crosstool-ng-1.24.0.tar.bz2 && \
	pushd crosstool-ng-1.24.0 && \
	./configure && \
	make -j4 && \
	sudo make install && \
	popd

ct-ng build