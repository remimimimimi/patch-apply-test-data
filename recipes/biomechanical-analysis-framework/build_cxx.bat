mkdir build
cd build

cmake %CMAKE_ARGS% -G "Ninja" ^
    -DBUILD_TESTING:BOOL=ON ^
    -DFRAMEWORK_COMPILE_tests:BOOL=ON ^
    -DFRAMEWORK_COMPILE_examples:BOOL=OFF ^
    %SRC_DIR%
if errorlevel 1 exit 1

type CMakeCache.txt

:: Build.
cmake --build . --config Release
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1

:: Test.
:: HumanIK skipped due to https://github.com/ami-iit/biomechanical-analysis-framework/issues/82, re-enable once https://github.com/ami-iit/biomechanical-analysis-framework/pull/84 is relaesed
ctest --output-on-failure -C Release -E "HumanIK"
if errorlevel 1 exit 1
