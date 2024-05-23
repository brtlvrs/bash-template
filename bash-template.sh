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

    _isNextArgValue(){
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

    # Return the processed arguments
    local total_args="${#processed_args[@]}"

    for ((i = 0; i < ${#processed_args[@]}; i++)); do
        local arg="${processed_args[$i]}"
        local next_arg="${processed_args[$((i + 1))]}"
        case "$arg" in
            --fruit|-f)
                _isNextArgValue || return 1
                fruit="$next_arg"
                echo "Fruit: $fruit"
                ((i++)) # Skip the next element since it's a value
                continue
                ;;
            --color|-c)
                _isNextArgValue || return 1
                color="$next_arg"
                echo "Color: $color"
                continue
                ;;
            --help|-h)
                if [[  $((i+1)) -lt $total_args ]] && [[  "$next_arg" != -* ]]; then
                    echo "WARNING: didn't expect a value argument after ${processed_args[$i]}"
                fi
                _usage
                continue
                ;;
            *)
                echo "WARNING: Unknown argument: ${processed_args[$i]}"
                return 1
                ;;
        esac
    done
}

_guardrails "$@" || exit 1
_procesArgs "$@"

