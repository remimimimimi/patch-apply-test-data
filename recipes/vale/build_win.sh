#!/usr/bin/env bash
set -eux -o pipefail

module="github.com/errata-ai/vale"

GOPATH="$( pwd )"
export GOPATH
export GOROOT="${BUILD_PREFIX}/go"
export GOOS=windows
export GOARCH=amd64
export CGO_ENABLED=1
export GO111MODULE=on

command -v go
env | grep GOROOT
go version

pushd "src/${module}"
    go get -v "./cmd/${PKG_NAME}"
    go build \
        -ldflags "-s -w -X main.version=${PKG_VERSION}" \
        -o "${PREFIX}/bin/${PKG_NAME}.exe" \
        "./cmd/${PKG_NAME}" \
        || exit 1
    # except the first, all --ignores are stdlib, found for some reason
    go-licenses save "./cmd/${PKG_NAME}" \
        --save_path "${SRC_DIR}/license-files" \
        --ignore=archive/tar \
        --ignore=archive/zip \
        --ignore=bufio \
        --ignore=bytes \
        --ignore=cmp \
        --ignore=compress/flate \
        --ignore=compress/gzip \
        --ignore=container/list \
        --ignore=context \
        --ignore=crypto \
        --ignore=crypto/aes \
        --ignore=crypto/cipher \
        --ignore=crypto/dsa \
        --ignore=crypto/ecdsa \
        --ignore=crypto/ed25519 \
        --ignore=database/sql/driver \
        --ignore=embed \
        --ignore=encoding \
        --ignore=encoding/csv \
        --ignore=errors \
        --ignore=flag \
        --ignore=fmt \
        --ignore=github.com/jdkato/go-tree-sitter-julia/julia \
        --ignore=github.com/xi2/xz \
        --ignore=hash \
        --ignore=hash/adler32 \
        --ignore=hash/crc32 \
        --ignore=hash/crc64 \
        --ignore=html \
        --ignore=internal/abi \
        --ignore=internal/asan \
        --ignore=internal/bisect \
        --ignore=internal/bytealg \
        --ignore=internal/byteorder \
        --ignore=internal/chacha8rand \
        --ignore=internal/concurrent \
        --ignore=internal/coverage/rtcov \
        --ignore=internal/cpu \
        --ignore=internal/filepathlite \
        --ignore=internal/fmtsort \
        --ignore=internal/goarch \
        --ignore=internal/godebug \
        --ignore=internal/goexperiment \
        --ignore=internal/goos \
        --ignore=internal/intern \
        --ignore=internal/itoa \
        --ignore=internal/msan \
        --ignore=internal/nettrace \
        --ignore=internal/oserror \
        --ignore=internal/poll \
        --ignore=internal/profilerecord \
        --ignore=internal/race \
        --ignore=internal/reflectlite \
        --ignore=internal/runtime/atomic \
        --ignore=internal/runtime/exithook \
        --ignore=internal/runtime/maps \
        --ignore=internal/runtime/math \
        --ignore=internal/runtime/sys \
        --ignore=internal/safefilepath \
        --ignore=internal/saferio \
        --ignore=internal/singleflight \
        --ignore=internal/stringslite \
        --ignore=internal/sync \
        --ignore=internal/syscall/execenv \
        --ignore=internal/syscall/windows \
        --ignore=internal/syscall/windows/registry \
        --ignore=internal/sysinfo \
        --ignore=internal/testlog \
        --ignore=internal/unsafeheader \
        --ignore=internal/weak \
        --ignore=io \
        --ignore=io/fs \
        --ignore=iter \
        --ignore=log \
        --ignore=maps \
        --ignore=math \
        --ignore=mime \
        --ignore=mime/multipart \
        --ignore=net \
        --ignore=net/http \
        --ignore=net/url \
        --ignore=os \
        --ignore=os/exec \
        --ignore=os/signal \
        --ignore=os/user \
        --ignore=path \
        --ignore=path/filepath \
        --ignore=reflect \
        --ignore=regexp \
        --ignore=runtime \
        --ignore=runtime/debug \
        --ignore=slices \
        --ignore=sort \
        --ignore=strconv \
        --ignore=strings \
        --ignore=sync \
        --ignore=syscall \
        --ignore=testing \
        --ignore=text/tabwriter \
        --ignore=text/template \
        --ignore=text/template/parse \
        --ignore=time \
        --ignore=unicode \
        --ignore=unicode/utf16 \
        --ignore=unicode/utf8 \
        --ignore=unique \
        --ignore=vendor/golang.org/x/crypto/chacha20 \
        --ignore=vendor/golang.org/x/crypto/chacha20poly1305 \
        --ignore=vendor/golang.org/x/crypto/cryptobyte \
        --ignore=vendor/golang.org/x/crypto/cryptobyte/asn1 \
        --ignore=vendor/golang.org/x/crypto/hkdf \
        --ignore=vendor/golang.org/x/crypto/internal/alias \
        --ignore=vendor/golang.org/x/crypto/internal/poly1305 \
        --ignore=vendor/golang.org/x/crypto/sha3 \
        --ignore=vendor/golang.org/x/net/dns/dnsmessage \
        --ignore=vendor/golang.org/x/net/http/httpguts \
        --ignore=vendor/golang.org/x/net/http/httpproxy \
        --ignore=vendor/golang.org/x/net/http2/hpack \
        --ignore=vendor/golang.org/x/net/idna \
        --ignore=vendor/golang.org/x/sys/cpu \
        --ignore=vendor/golang.org/x/text/secure/bidirule \
        --ignore=vendor/golang.org/x/text/transform \
        --ignore=vendor/golang.org/x/text/unicode/bidi \
        --ignore=vendor/golang.org/x/text/unicode/norm \
        --ignore=weak \
        || exit 1
popd

#
#   TODO: this fails currently... maybe could be batched?
#
#       find: The environment is too large for exec().
#
# CLEAN_GO_PATH=$( go env GOPATH )
# export CLEAN_GO_PATH
# find "${CLEAN_GO_PATH}" -type d -exec chmod +w {} \;
