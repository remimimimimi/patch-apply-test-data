#!/bin/env bash

mkdir build
cd build

cmake ${CMAKE_ARGS} \
      -G "Ninja" \
      -DRAPIDJSON_HAS_STDSTRING=ON \
      -DRAPIDJSON_BUILD_TESTS=OFF \
      -DRAPIDJSON_BUILD_EXAMPLES=OFF \
      -DRAPIDJSON_BUILD_DOC=OFF \
      ..

cmake --install .
