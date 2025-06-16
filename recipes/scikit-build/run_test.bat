
:: Update PATH to ensure mingw compiler is not found
pushd %RECIPE_DIR%
call rmpath C:\\Program Files\\Git\\mingw64\\bin
call rmpath C:\\ProgramData\\Chocolatey\\bin
call rmpath C:\\Strawberry\\c\\bin
popd

pytest -m "not fortran and not isolated" -k "not test_issue352_isolated_environment_support and not test_configure_with_cmake_args and not test_generator_selection" -v
