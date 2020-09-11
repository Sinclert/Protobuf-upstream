#!/usr/bin/env sh

# The script exits when a command fails or it uses undeclared variables
set -o errexit
set -o nounset


# shellcheck disable=SC1090
. "$(dirname "$0")/common/funcs.sh"


WRITABLE_DIR="${1}"

PROTOC_BINARY_PATH="${2}"
PROTOC_OUTPUT_LANG="python"


GENERATOR_FUNCTION() {
    package_name="${1}"
    module_name="${2}"

    output_folder="${WRITABLE_DIR}/schemas/${PROTOC_OUTPUT_LANG}/${package_name}"
    mkdir -p "${output_folder}"

    # shellcheck disable=SC2046
    ${PROTOC_BINARY_PATH} \
        --proto_path "${SCHEMAS_FOLDER_PATH}" \
        --python_betterproto_out="${output_folder}" \
        $(expand_module_files "${module_name}")
}


# Call the iterator passing the generator function
iterate_schemas GENERATOR_FUNCTION
