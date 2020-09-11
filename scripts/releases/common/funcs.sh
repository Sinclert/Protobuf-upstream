#!/bin/sh

# The script exits when a command fails or it uses undeclared variables
set -o errexit
set -o nounset


VERSION_FILE="VERSION"


bump_up_version() {
    repo_local_path="${1}"

    version_path="${repo_local_path}/${VERSION_FILE}"
    version_old=$(cat "${version_path}")
    version_new=$((version_old + 1))

    printf "%s\n" "${version_new}" > "${version_path}"
}


release_schemas() {
    repo_local_path="${1}"

    # The directory is only changed in this context
    (
        cd "${repo_local_path}"
        git add --all
        git commit -m "Automatic version release"
        git push
        make release
    )
}
