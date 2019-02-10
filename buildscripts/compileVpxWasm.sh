#!/bin/bash

dir=`pwd`

# set up the build directory
mkdir -p build
cd build

mkdir -p wasm
cd wasm

mkdir -p root
mkdir -p libvpx
cd libvpx

#

# finally, run configuration script
EMCONFIGURE_JS=1 \
  emconfigure ../../../libvpx/configure \
    --prefix="$dir/build/wasm/root" \
    --target=generic-gnu \
    --extra-cflags=-s\ WASM=1\ -DWASM\ -I`dirname \`which emcc\``/system/lib/libcxxabi/include/ \
    --disable-multithread \
    --enable-vp9-decoder \
    --disable-vp8-encoder \
    --disable-vp9-encoder \
    --enable-shared \
    --disable-docs \
    --disable-examples

# compile libvpx
emmake make -j4
emmake make install

cd ..
cd ..
cd ..
