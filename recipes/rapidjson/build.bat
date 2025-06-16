mkdir build
cd build

cmake %CMAKE_ARGS% ^
      -G "Ninja" ^
      -D RAPIDJSON_HAS_STDSTRING=ON ^
      -D RAPIDJSON_BUILD_TESTS=OFF ^
      -D RAPIDJSON_BUILD_EXAMPLES=OFF ^
      -D RAPIDJSON_BUILD_DOC=OFF ^
      ..
if errorlevel 1 exit 1

cmake --install .
if errorlevel 1 exit 1
