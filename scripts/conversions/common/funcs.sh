#!/usr/bin/env sh

# The script exits when a command fails or it uses undeclared variables
set -o errexit
set -o nounset


# Path from the shell scripts sourcing it
PROJECT_DIR="$(dirname "$0")/../.."

SCHEMAS_FOLDER_NAME="schemas"
SCHEMAS_FOLDER_PATH="${PROJECT_DIR}/${SCHEMAS_FOLDER_NAME}"


expand_module_files() {
    find "${1}" -type f -name "*.proto" -print0 | xargs -0 -I {} echo "{}"
}


pruned_file_path() {
    file_path="${1}"
    nodes_len="${2}"
    echo "${file_path}" | rev | cut -d "/" -f 1-"${nodes_len}" | rev
}


iterate_schemas() {
    generation_func="${1}"

    for package in "${SCHEMAS_FOLDER_PATH}"/*; do
        if ! [ -d "${package}" ]; then
            continue
        fi

        package_name=$(pruned_file_path "${package}" 1)

        echo "Accessing package ${package_name}"
        for module in "${package}"/*; do
            if ! [ -d "${module}" ]; then
                continue
            fi

            module_name=$(pruned_file_path "${module}" 1)

            echo "Generating module ${module_name}"
            ${generation_func} "${package_name}" "${module}"
        done
    done
}
