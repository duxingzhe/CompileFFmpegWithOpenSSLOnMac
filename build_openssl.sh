#!/bin/bash

function build_one
{

PWD='pwd'

cd openssl-1.1.1c

./config shared no-ssl2 no-ssl3 no-comp no-hw no-engine --openssldir=$PWD/../mac/openssl --prefix=$PWD/../mac/openssl

make clean
make depend
make CALC_VERSIONS="SHLIB_COMPAT=; SHLIB_SOVER=" MAKE="make -e" all
echo "place-holder make target for avoiding symlinks" >> $PWD/../linux/openssl/lib/link-shared
make SHLIB_EXT=.so install_sw

}

build_one
