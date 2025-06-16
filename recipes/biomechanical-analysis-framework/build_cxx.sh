#!/bin/sh

rm -rf build
mkdir -p build

cd build

cmake ${CMAKE_ARGS} -GNinja .. \
    -DBUILD_TESTING:BOOL=ON \
    -DFRAMEWORK_COMPILE_tests:BOOL=ON \
    -DFRAMEWORK_COMPILE_examples:BOOL=OFF
cat CMakeCache.txt

cmake --build . --config Release
cmake --build . --config Release --target install

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
  # HumanIK skipped due to https://github.com/ami-iit/biomechanical-analysis-framework/issues/82, re-enable once https://github.com/ami-iit/biomechanical-analysis-framework/pull/84 is relaesed
  ctest --output-on-failure -C Release -E "HumanIK"
fi
