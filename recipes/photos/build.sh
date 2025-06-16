#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* config/

# Regenerate the configure script
autoreconf -fvi

./configure --prefix="${PREFIX}" --with-hepmc="${PREFIX}" --with-hepmc3="${PREFIX}"
# Yes, LD=CXX is intentional..
make -j${CPU_COUNT} LD=$CXX
make install
