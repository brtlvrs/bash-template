main::_procesArgs(){
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