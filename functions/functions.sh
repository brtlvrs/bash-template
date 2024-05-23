#!/bin/bash
#set -e

_source_functions() {
    # function to find al bash scripts recursivly from all subfolders under the given base_path

    local base_path="$1"
    declare -a files_array

    # guardrail
    [[ ! -d "$base_path" ]] && { echo "Invalid path $base_path">&2; exit 1; }

    # find all bash scripts
    mapfile -t files_array < <(find "$base_path" -mindepth 2 -type f -name '*.sh'  | sort)

    # source them all
    for file in "${files_array[@]}"; do
       source "$file"
    done
}


# Get the directory of the script, handling symbolic links
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_source_functions "$SCRIPT_DIR"
