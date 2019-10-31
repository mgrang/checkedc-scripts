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

for arg
do
  case $arg in
    --src=?*) SRC_DIR=${arg##*=};;
    --help|-h) usage;;
    -*|*) usage; break;;
  esac
done

#checkout llvm-project
git clone https://github.com/llvm/llvm-project.git src
