#!/bin/bash
source ./functions/functions.sh

#-- functions
_usage(){
    cat <<EOF

            bash-template.sh

    This is a template or demo bash script, containing some standardized functions.
    The purpose is also to demonstrate some solutions for using arguments.
    The way arguments are handled is that they are first moved into an array. 
    And then each argument that has a format like -key=value is split into arguments
    

    Options:

    -h | --help             This message
    -f | --fruit <value>    [string] fruit
    -c | --color <value>    [int] color
    -w | --world            run hello world routine

EOF
}

_guardrails(){
    # this is the guardrails function. 
    # in the function all guardrails are defined for this script.
    # when a guardrail is hit the fubction returns status 1, else it will return status 0

    # check if we have at least one argument
    if [[ $# -eq 0 ]]; then
        echo "WARNING: Expected at least one argument, got none.">&2
        _usage
        return 1
    fi
}

_procesArgs(){
# This function proces all arguments.
# first it will create an array and pushes each argument as an item into the array.
# when an argument is in the format key=value, it is split into two arguments, and each one
# is pushed into the array.
# Then it walks through the array and processes the arguments with a case statement.

# Initialize an array to hold the processed arguments
    local args=("$@")
    local processed_args=()

    # local functions

    _hasNoValue(){
        # argument guardrail function, to be used when an argument should have a value.
        # returns 0 when an argument has a value, returns 1 when it doesn't

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
        # argument guardrail function, to be used when an argument shouldn't have a value
        # retuns 0 when an argument hasn't a value, returns  when it does

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
            --world|-w) # hello world example
                _hasValue || return 1
                common::helloWorld
                continue
                ;;
            --help|-h) # displays the help message
                _hasValue
                _usage
                return 0 # exit 
                ;;
            *) # unknown argument, let's quit
                echo "WARNING: Unknown argument: ${processed_args[$i]}"
                return 1
                ;;
        esac
    done
}

#-- MAIN routine
_guardrails "$@" || exit 1
_procesArgs "$@" || exit 1

