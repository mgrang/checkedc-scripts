#!/bin/bash

usage() {
  echo "Usage: $0"
  echo "  Optional arguments:"
  echo "    --src=<SRC_DIR>"
  echo "      Path to the directory where the sources should be"
  echo "      checked out. The directory is created if it does"
  echo "      not exist. Defaults to $PWD/src."
  exit 1
}

SRC_DIR=$PWD/src

for arg
do
  case $arg in
    --src=?*) SRC_DIR=${arg##*=};;
    --help|-h) usage;;
    -*|*) usage; break;;
  esac
done

mkdir -p $SRC_DIR && cd $SRC_DIR &&

#checkout llvm
git clone https://github.com/Microsoft/checkedc-llvm llvm &&

#checkout clang
cd $SRC_DIR/tools
git clone https://github.com/Microsoft/checkedc-clang clang &&

#checkout checkedc
cd $SRC_DIR/llvm/projects/checkedc-wrapper &&
git clone https://github.com/Microsoft/checkedc &&

cd $SRC_DIR
