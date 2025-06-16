#!/bin/bash
set -ex

# Regenerate the configure script
autoreconf -fvi

./configure --prefix=$PREFIX

make -j${CPU_COUNT} VERBOSE=1
make check
make install
