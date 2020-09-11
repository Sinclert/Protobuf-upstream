#!/usr/bin/env sh

# The script exits when a command fails or it uses undeclared variables
set -o errexit
set -o nounset


# Path from the shell scripts sourcing it
PROJECT_DIR="$(dirname "$0")/../.."


download_protobuf_zip() {
    writable_dir="${1}"
    proto_platform="${2}"
    proto_releases="${3}"
    proto_version="${4}"

    zip_download_folder="${writable_dir}/downloads"
    zip_download_name="protoc_${proto_platform}_${proto_version}.zip"
    zip_download_path="${zip_download_folder}/${zip_download_name}"

    zip_extract_folder="compilers/${proto_platform}"
    zip_extract_path="${PROJECT_DIR}/${zip_extract_folder}"

    # Download the ZIP compiled binaries
    mkdir -p "${zip_download_folder}"
    curl \
        --location \
        --silent \
        --show-error \
        --output "${zip_download_path}" \
        "${proto_releases}/v${proto_version}/protoc-${proto_version}-${proto_platform}-x86_64.zip"

    # Extract the ZIP contents into the desired folder
    mkdir -p "${zip_extract_folder}"
    unzip -q "${zip_download_path}" -d "${zip_extract_path}"
    rm "${zip_download_path}"
}
