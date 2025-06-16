@echo on

mkdir build
cd build

cmake -G "Ninja" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DOSQP_ALGEBRA_BACKEND=builtin ^
    -DOSQP_BUILD_UNITTESTS:BOOL=ON ^
    -DOSQP_BUILD_SHARED_LIB:BOOL=ON ^
    -DBUILD_SHARED_LIBS=ON ^
    ..
if %ERRORLEVEL% neq 0 exit 1

:: Build.
cmake --build . --config Release
if %ERRORLEVEL% neq 0 exit 1

:: Install.
cmake --install .
if %ERRORLEVEL% neq 0 exit 1
