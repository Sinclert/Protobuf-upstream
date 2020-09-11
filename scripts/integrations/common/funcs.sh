#!/bin/sh

# The script exits when a command fails or it uses undeclared variables
set -o errexit
set -o nounset


# Check initial requirements
command -v rsync > /dev/null || { echo "rsync package not installed"; exit 1; }


git_clone_repository() {
    repo_remote_url="${1}"
    repo_local_path="${2}"

    rm -rf "${repo_local_path}"
    git clone \
        --depth 1 \
        --quiet \
        --single-branch \
        "${repo_remote_url}" \
        "${repo_local_path}"
}


git_update_schemas() {
    repo_local_path="${1}"
    repo_schemas_dir="${2}"
    gen_schemas_path="${3}"

    rsync \
        --recursive \
        --remove-source-files \
        "${gen_schemas_path}"/* \
        "${repo_local_path}/${repo_schemas_dir}"

    # The directory is only changed in this context
    (
        cd "${repo_local_path}"
        git add --all
        git commit -m "Automatic schemas update"
        git push
    )
}
