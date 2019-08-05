#!/bin/bash

set -e

######################################################
############### START build_one ######################
######################################################

function build_one
{

PWD=`pwd`

cd ffmpeg-4.1.3

TOP_ROOT=$PWD/..
PREFIX=$TOP_ROOT/mac/ffmpeg

FFMPEG_DIR=$TOP_ROOT/mac/ffmpeg
FFMPEG_BINARY_DIR=$FFMPEG_DIR/lib
FFMPEG_INCLUDE_DIR=$FFMPEG_DIR/include

OPENSSL_DIR=$TOP_ROOT/openssl
OPENSSL_BINARY_DIR=$OPENSSL_DIR/lib
OPENSSL_INCLUDE_DIR=$OPENSSL_DIR/include

SSL_EXTRA_LDFLAGS="-L$OPENSSL_BINARY_DIR"
SSL_EXTRA_CFLAGS="-I$OPENSSL_INCLUDE_DIR"

./configure --cc=/usr/bin/clang --prefix=$PREFIX \
    --incdir=$FFMPEG_INCLUDE_DIR \
    --libdir=$FFMPEG_BINARY_DIR \
    --extra-cflags="$OPTIMIZE_CFLAGS $SSL_EXTRA_CFLAGS" \
    --extra-ldflags="-W -lc -lm -ldl -lz $SSL_EXTRA_LDFLAGS -DOPENSSL_API_COMPAT=0x00908000L" \
    --disable-static \
    --disable-ffplay \
    --disable-ffmpeg \
    --disable-ffprobe \
    --disable-doc \
    --disable-symver \
    --enable-gpl \
    --enable-postproc \
    --disable-encoders \
    --disable-muxers \
    --disable-bsfs \
    --disable-indevs \
    --disable-outdevs \
    --disable-devices \
    --enable-asm \
    --enable-shared \
    --enable-small \
    --enable-encoder=png \
    --enable-nonfree \
    --enable-openssl \
    --enable-protocol=file,ftp,http,https,httpproxy,hls,mmsh,mmst,pipe,rtmp,rtmps,rtmpt,rtmpts,rtp,sctp,srtp,tcp,udp \
    $ADDITIONAL_CONFIGURE_FLAG

make clean
make -j8
make install
}

build_one
