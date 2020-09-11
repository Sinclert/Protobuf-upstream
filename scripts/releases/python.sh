#!/bin/sh

# The script exits when a command fails or it uses undeclared variables
set -o errexit
set -o nounset


# shellcheck disable=SC1090
. "$(dirname "$0")/common/funcs.sh"


WRITABLE_DIR="${1}"

REPO_NAME="<DOWNSTREAM_REPOSITORY_NAME>"        # Change me


bump_up_version "${WRITABLE_DIR}/integrations/${REPO_NAME}"
release_schemas "${WRITABLE_DIR}/integrations/${REPO_NAME}"

