TOP=

if [[ -z "$1" ]]; then
  echo "Specify target to build. Valid targets: binutils|gcc|gdb"
  exit 1
fi

if [[ $1 == "binutils" ]]; then
  TARG=binutils

  cd $TOP
  mkdir -p src build/$TARG

  cd $TOP/src
  wget https://ftp.gnu.org/gnu/binutils/binutils-2.35.tar.gz && tar -xf binutils-2.35.tar.gz

  cd $TOP/build/$TARG
  ../../src/$TARG-2.35/configure --prefix $TOP/install --target arm-none-eabi --disable-multilib
  make -j32 && make install

elif [[ $1 == "gcc" ]]; then
  TARG=gcc

  cd $TOP
  mkdir -p src build/$TARG

  cd $TOP/src
  git clone https://github.com/gcc-mirror/gcc.git gcc-9.3.0
  cd gcc-9.3.0 && git checkout releases/gcc-9.3.0
#  wget https://ftp.gnu.org/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz && tar -xf gcc-9.3.0.tar.gz

  cd $TOP/src/$TARG-9.3.0
  ./contrib/download_prerequisites

  cd $TOP/build/$TARG
  ../../src/$TARG-9.3.0/configure --prefix $TOP/install --target arm-none-eabi --disable-multilib --enable-languages=c,c++ --without-headers
  make -j32 all-gcc && make install-gcc

elif [[ $1 == "gdb" ]]; then
  TARG=gdb

  cd $TOP
  mkdir -p src build/$TARG

  cd $TOP/src
  wget https://ftp.gnu.org/gnu/gdb/gdb-9.1.tar.gz && tar -xf gdb-9.1.tar.gz

  cd $TOP/build/$TARG
  ../../src/$TARG-9.1/configure --prefix $TOP/install --target arm-none-eabi --disable-multilib
  make -j32 && make install

fi
