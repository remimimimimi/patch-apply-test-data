cd bindings
rmdir /s /q build
mkdir build
cd build

cmake %CMAKE_ARGS% -G "Ninja" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_SHARED_LIBS:BOOL=ON ^
    -DPython3_EXECUTABLE:PATH=%PYTHON% ^
    -DFRAMEWORK_DETECT_ACTIVE_PYTHON_SITEPACKAGES:BOOL=ON ^
    -DBAF_PYTHON_PIP_METADATA_INSTALLER:STRING="conda" ^
    ..
if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1

:: Tests are not installed, so we run them during the build
:: We run them directly via pytest so we detect if we are not compiling some required components
:: At the moment the baf python bindings do not have any test, re-enable this if they are added
:: cd ..
:: pytest -v
:: if errorlevel 1 exit 1
