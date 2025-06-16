#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export CARGO_PROFILE_RELEASE_STRIP=symbols
export CARGO_PROFILE_RELEASE_LTO=fat

cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

pushd frontend
pnpm install
pnpm-licenses generate-disclaimer --prod --output-file=../THIRDPARTY-frontend.yml
popd

# native extensions currently not available on other platforms
# https://github.com/benfred/py-spy/issues/729, https://github.com/benfred/py-spy/pull/330
if [[ "$target_platform" == linux-64 ]]
then
    export RUSTFLAGS="-C link-arg=-Wl,-rpath-link,${PREFIX}/lib -L${PREFIX}/lib"
    cargo install --no-track --locked --features unwind --root "$PREFIX" --path .
elif [[ "$target_platform" == linux* ]]
then
    export RUSTFLAGS="-C link-arg=-Wl,-rpath-link,${PREFIX}/lib -L${PREFIX}/lib"
    cargo install --no-track --locked --root "$PREFIX" --path .
else
    cargo install --no-track --locked --root "$PREFIX" --path .
fi
