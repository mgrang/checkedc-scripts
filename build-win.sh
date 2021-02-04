# In cmd prompt:

# Checkout.
cd C:\mgrang\checkedc\master
git clone -c core.autocrlf=false https://github.com/Microsoft/checkedc-clang src
cd src\llvm\projects\checkedc-wrapper
git clone https://github.com/Microsoft/checkedc

# Build.
set TOP=C:\mgrang\checkedc\master
mkdir %TOP%\build
cd %TOP%\build
set PATH="C:\GnuWin32\bin";%PATH%
@call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64
cmake -G Ninja -DLLVM_ENABLE_PROJECTS=clang -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON -DLLVM_USE_CRT_RELEASE=MT -DCMAKE_BUILD_TYPE=Release %TOP%\src\llvm
ninja
