:: Create an navigate to an out of source build directory
mkdir build
cd build

if "%variant%" == "luajit" (
    set LOVE_JIT=ON
) else (
    set LOVE_JIT=OFF
)

:: Configure the project using CMake
cmake -G Ninja ^
    %CMAKE_ARGS% ^
    -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -D LOVE_JIT=%LOVE_JIT% ^
    %SRC_DIR%
if errorlevel 1 exit 1

:: Build the project using CMake
cmake --build .
if errorlevel 1 exit 1

:: Install the project using CMake
cmake --build . --target install
if errorlevel 1 exit 1
