#!/bin/bash

set -exuo pipefail

# Remove bundled dependencies
rm -rf crt

export AWS_C_INSTALL=$PREFIX
$PYTHON -m pip install . -vv
