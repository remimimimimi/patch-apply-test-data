#!/bin/sh

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

CXXFLAGS="${CXXFLAGS} -DPYBIND11_DETAILED_ERROR_MESSAGES"

cd ${SRC_DIR}/bindings

rm -rf build
mkdir build
cd build

cmake ${CMAKE_ARGS} -GNinja .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DPython3_EXECUTABLE:PATH=$PYTHON \
    -DFRAMEWORK_DETECT_ACTIVE_PYTHON_SITEPACKAGES:BOOL=ON \
    -DBAF_PYTHON_PIP_METADATA_INSTALLER:STRING="conda"

ninja -v
cmake --build . --config Release --target install

# At the moment the baf python bindings do not have any test, re-enable this if they are added
# if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" ]]; then

  # Tests are not installed, so we run them during the build
  # We run them directly via pytest so we detect if we are not compiling some required components
  #cd ..
  #pytest -v
# fi
