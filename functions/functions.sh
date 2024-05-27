#!/bin/bash
#set -e

# This script will source all bash scripts in subfolders relative to the location of this script
# the order of sourcing is alphabeticly, based on the files full path.

_source_functions() {
    # private function to find al bash scripts recursivly from all subfolders under the given base_path

    local base_path="$1"
    declare -a files_array

    # guardrail, check if given path is valid
    if [[ ! -d "$base_path" ]]; then
        echo "Invalid path $base_path">&2
        $exitErr_cmd
    fi

    # find all bash scripts in subfolders and sort them alphabeticly
    mapfile -t files_array < <(find "$base_path" -mindepth 2 -type f -name '*.sh'  | sort)

    # source them all
    for file in "${files_array[@]}"; do
       source "$file"
    done
}

#-- MAIN

# set exit strategy on error
exitErr_cmd="exit 1"
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    exitErr_cmd="return 1"
fi

# Determine the location of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# source all bash scripts in subfolders relative to determined location
_source_functions "$SCRIPT_DIR"

# let's cleanup, remove the private function from memory
unset -f _source_functions
unset SCRIPT_DIR

# let's exit with a bang, when _source_functions returns an error
[[ "$exit_with_error" == "true" ]] && $exitErr_cmd