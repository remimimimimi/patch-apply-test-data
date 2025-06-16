#!/bin/bash

mkdir build
cd build

cmake ${CMAKE_ARGS} -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_INSTALL_LIBDIR=lib -DLIBTINS_BUILD_SHARED=ON ..
ninja -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    ctest -VV --output-on-failure
fi
ninja install
