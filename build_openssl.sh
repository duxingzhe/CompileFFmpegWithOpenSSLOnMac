#!/bin/bash

function build_one
{

PWD='pwd'

cd openssl-1.1.1c

./Configure darwin64-x86_64-cc --openssldir=$PWD/../mac/openssl --prefix=$PWD/../mac/openssl

make clean
make depend
make CALC_VERSIONS="SHLIB_COMPAT=; SHLIB_SOVER=" MAKE="make -e" all
echo "place-holder make target for avoiding symlinks" >> $PWD/../linux/openssl/lib/link-shared
make SHLIB_EXT=.so install_sw

}

build_one
