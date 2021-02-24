#!/bin/bash

# Make sure to install the following before building the compiler for x86:
# sudo apt install gcc-multilib g++-multilib lib32z1-dev

PROG=${0##*/}

usage() {
  echo >&2 "
Usage: $PROG [options]
  --src=<SRC_DIR>
    SRC_DIR must have the following sources. You can use
    checkout.sh to checkout the sources.
      SRC_DIR/llvm
      SRC_DIR/llvm/tools/clang
      SRC_DIR/llvm/projects/checkedc-wrapper/checkedc
  --build=<BUILD_DIR>
    BUILD_DIR points to your build dir
  --prefix=<INSTALL_DIR>
  --install=<INSTALL_DIR>
    INSTALL_DIR points to the installation of toolchain
  --build-mode=[Release|Debug]
  --assertion-mode=[ON|OFF]
  --help Display this usage and exit
"
  exit 1
}

check_status(){
  if [ $? -ne 0 ]; then
    echo Failed during configuration/build && exit 1
  fi
}

# Set default values.
BUILD_MODE=Release
ASSERTION_MODE=ON
TARGETS_TO_BUILD="X86"

SRC_DIR=$PWD/src
BUILD_DIR=$PWD/build
INSTALL_DIR=$PWD/install

for arg
do
  case $arg in
    --src=*) SRC_DIR=${arg##*=};;
    --build=*) BUILD_DIR=${arg##*=};;
    --prefix=*) INSTALL_DIR=${arg##*=};;
    --install=*) INSTALL_DIR=${arg##*=};;
    --build-mode=*) BUILD_MODE=${arg##*=};;
    --assertion-mode=*) ASSERTION_MODE=${arg##*=};;
    --help) usage; break;;
    -*|*) usage; break;;
  esac
  shift
done

mkdir -p $BUILD_DIR/llvm && cd $BUILD_DIR/llvm

cmake -G Ninja \
 -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
 -DCMAKE_BUILD_TYPE=$BUILD_MODE \
 -DLLVM_ENABLE_ASSERTIONS=$ASSERTION_MODE \
 -DLLVM_TARGETS_TO_BUILD="$TARGETS_TO_BUILD" \
 -DLLVM_CCACHE_BUILD=ON \
 -DLLVM_BUILD_32_BITS=ON \
 -DLLVM_LIT_ARGS=-v \
 $SRC_DIR/llvm || check_status

ninja || check_status
ninja install || check_status
