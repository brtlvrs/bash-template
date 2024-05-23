#!/bin/bash
source ./functions/functions.sh

_usage(){
    cat <<EOF

            bash-template.sh

    bla bla bla bla usage bla

    Options:

    -h | --help             This message
    -f | --fruit <value>    fruit
    -c | --color <value>    color

EOF
}

_guardrails(){
    # check if we have at least one argument
    if [[ $# -eq 0 ]]; then
        echo "WARNING: Expected at least one argument, got none.">&2
        _usage
        return 1
    fi
}

_procesArgs(){

# Initialize an array to hold the processed arguments
    local args=("$@")
    local processed_args=()

    _hasNoValue(){
        # Used to check if an argument has no value
        if [[ $((i + 1)) -ge $total_args ]]; then
            echo "WARNING: No value given for $arg" >&2
            return 1
        fi
        if [[ "$next_arg" == -* ]]; then
            echo "WARNING: expected a value for $arg but got $next_arg" >&2
            return 1
        fi
        ((i++)) # Skip the next element since it's a value
        return 0
    }

    _hasValue(){
        # Used to check if an argument is followed by a value
        if [[  $((i+1)) -lt $total_args ]] && [[  "$next_arg" != -* ]]; then
            echo "WARNING: didn't expect a value argument after ${processed_args[$i]}"
            return 1
        fi
        return 0
    }

    # Iterate over the arguments
    for arg in "${args[@]}"; do
        if [[ "$arg" == *"="* ]]; then
            # Split the argument on the first '=' character
            local key="${arg%%=*}"
            local value="${arg#*=}"
            # Add the key and value as separate elements in the array
            processed_args+=("$key")
            processed_args+=("$value")
        else
            # Add the argument as is if it doesn't contain '='
            processed_args+=("$arg")
        fi
    done

    local total_args="${#processed_args[@]}"

    # proces all arguments
    for ((i = 0; i < ${#processed_args[@]}; i++)); do
        local arg="${processed_args[$i]}"
        local next_arg="${processed_args[$((i + 1))]}"

        case "$arg" in
            --fruit|-f)
                _hasNoValue || return 1
                fruit="$next_arg"
                echo "Fruit: $fruit"
                continue
                ;;
            --color|-c)
                _hasNoValue || return 1
                color="$next_arg"
                echo "Color: $color"
                continue
                ;;
            --help|-h) # help message
                _hasValue
                _usage
                return 0 # exit 
                ;;
            *)
                echo "WARNING: Unknown argument: ${processed_args[$i]}"
                return 1
                ;;
        esac
    done
}

_guardrails "$@" || exit 1
_procesArgs "$@" || exit 1

