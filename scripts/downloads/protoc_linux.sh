#!/usr/bin/env sh

# The script exits when a command fails or it uses undeclared variables
set -o errexit
set -o nounset


# shellcheck disable=SC1090
. "$(dirname "$0")/common/funcs.sh"


WRITABLE_DIR="${1}"

PROTO_PLATFORM="linux"
PROTO_RELEASES="https://github.com/protocolbuffers/protobuf/releases/download/"
PROTO_VERSION="3.12.3"


download_protobuf_zip \
    "${WRITABLE_DIR}" \
    "${PROTO_PLATFORM}" \
    "${PROTO_RELEASES}" \
    "${PROTO_VERSION}"
