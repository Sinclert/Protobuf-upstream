#!/bin/sh

# The script exits when a command fails or it uses undeclared variables
set -o errexit
set -o nounset


# shellcheck disable=SC1090
. "$(dirname "$0")/common/funcs.sh"


WRITABLE_DIR="${1}"

REPO_HOST="git@github.com:<ORGANIZATION_NAME>"      # Change me
REPO_NAME="<DOWNSTREAM_REPOSITORY_NAME>"            # Change me
REPO_LANG="python"
REPO_URL="${REPO_HOST}/${REPO_NAME}.git"

GEN_SCHEMAS_PATH="${WRITABLE_DIR}/schemas/${REPO_LANG}"
REPO_LOCAL_PATH="${WRITABLE_DIR}/integrations/${REPO_NAME}"
REPO_SCHEMAS_DIR="<DOWNSTREAM_REPOSITORY_FOLDER>"   # Change me


git_clone_repository "${REPO_URL}" "${REPO_LOCAL_PATH}"
git_update_schemas "${REPO_LOCAL_PATH}" "${REPO_SCHEMAS_DIR}" "${GEN_SCHEMAS_PATH}"
