#!/bin/sh

set -euxo pipefail

mkdir build
cd build

if [ "${variant}" == "luajit" ]; then
    LOVE_JIT=ON
else 
    LOVE_JIT=OFF
fi

# Configure using the CMakeFiles
cmake -G Ninja \
    ${CMAKE_ARGS} \
    -D CMAKE_INSTALL_PREFIX=$PREFIX \
    -D LOVE_JIT=$LOVE_JIT \
    $SRC_DIR

# Build
cmake --build .

# Install
cmake --build . --target install