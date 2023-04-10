
cmake %CMAKE_ARGS% ^
  -G "Ninja" ^
  -S %SRC_DIR% ^
  -B build ^
  -D CMAKE_BUILD_TYPE=Release ^
  -D CMAKE_INSTALL_PREFIX="%PREFIX%" ^
  -D CMAKE_C_COMPILER=clang-cl ^
  -D CMAKE_C_FLAGS="/EHsc %CFLAGS%" ^
  -D CMAKE_CXX_COMPILER=clang-cl ^
  -D CMAKE_CXX_FLAGS="/EHsc %CXXFLAGS%" ^
  -D CMAKE_INSTALL_LIBDIR="Library\lib" ^
  -D CMAKE_INSTALL_INCLUDEDIR="Library\include" ^
  -D CMAKE_INSTALL_BINDIR="Library\bin" ^
  -D CMAKE_INSTALL_DATADIR="Library\share" ^
  -D PYMOD_INSTALL_LIBDIR="/../../Lib/site-packages" ^
  -D ambit_INSTALL_CMAKEDIR="Library\share\cmake\ambit" ^
  -D Python_EXECUTABLE="%PYTHON%" ^
  -D LAPACK_LIBRARIES="%PREFIX%\\Library\\lib\\lapack.lib;%PREFIX%\\Library\\lib\\blas.lib" ^
  -D SHARED_ONLY=ON ^
  -D ENABLE_OPENMP=OFF ^
  -D CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
  -D ENABLE_XHOST=OFF ^
  -D ENABLE_GENERIC=OFF ^
  -D ENABLE_TESTS=OFF ^
  -D WITH_MPI=OFF ^
  -D CMAKE_VERBOSE_MAKEFILE=OFF ^
  -D CMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"
if errorlevel 1 exit 1

cmake --build build ^
      --config Release ^
      --target install ^
      -- -j %CPU_COUNT%
if errorlevel 1 exit 1

cd build
ctest --rerun-failed --output-on-failure
if errorlevel 1 exit 1

