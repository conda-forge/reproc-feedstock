mkdir -p build; cd build
rm -rf CMakeCache.txt

if [[ "$PKG_NAME" == *static ]]; then
    BUILD_TYPE="-DBUILD_SHARED_LIBS=OFF"
else
    BUILD_TYPE="-DBUILD_SHARED_LIBS=ON"
fi

cmake ${CMAKE_ARGS} .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DREPROC_TEST=ON \
      ${BUILD_TYPE}

make all -j${CPU_COUNT}
if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
    make test -j${CPU_COUNT}
fi
make install -j${CPU_COUNT}
