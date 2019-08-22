# Run this in git-bash on Windows.

cmake -T "host=x64" \
-G "Visual Studio 16 2019" \
-DLLVM_TARGETS_TO_BUILD="X86;ARM" \
-DLLVM_ENABLE_ASSERTIONS=ON \
-DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
-DLLVM_USE_CRT_RELEASE=MT \
-DCMAKE_BUILD_TYPE=Release \
/c/mgrang/checkedc/master/src/llvm 2>&1 | tee config.log

"C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\msbuild.exe" LLVM.sln -maxcpucount:8 2>&1 | tee build.log
