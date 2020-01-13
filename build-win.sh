# In git-bash:
cd /c/mgrang/checkedc
git clone -c core.autocrlf=false https://github.com/Microsoft/checkedc-clang src
cd src\llvm\projects
git clone https://github.com/Microsoft/checkedc
cd /c/mgrang/checkedc

# To build X86 toolchain.
cmake -A Win32 \
-G "Visual Studio 16 2019" \
-DLLVM_ENABLE_PROJECTS=clang \
-DLLVM_TARGETS_TO_BUILD="X86;ARM" \
-DLLVM_ENABLE_ASSERTIONS=ON \
-DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
-DLLVM_USE_CRT_RELEASE=MT \
-DCMAKE_BUILD_TYPE=Release \
/c/mgrang/checkedc/master/src/llvm 2>&1 | tee config.log

# To build X86-64 toolchain.
cmake -A x64 -Thost=x64 \
-G "Visual Studio 16 2019" \
-DLLVM_ENABLE_PROJECTS=clang \
-DLLVM_TARGETS_TO_BUILD=all \
-DLLVM_ENABLE_ASSERTIONS=ON \
-DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
-DLLVM_USE_CRT_RELEASE=MT \
-DCMAKE_BUILD_TYPE=Release \
/c/mgrang/checkedc/master/src/llvm 2>&1 | tee config.log

# In cmd prompt:
cd c:\mgrang\checkedc\build
"C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\msbuild.exe" LLVM.sln /p:CL_MPCount=3 /p:Configuration=Release /m
#"C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\msbuild.exe" LLVM.sln -maxcpucount:8 2>&1 | tee build.log
