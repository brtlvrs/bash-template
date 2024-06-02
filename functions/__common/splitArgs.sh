common::splitArgs() {
    # This function will split an argument in format of key=value into two arguments
    # the equal character is the divider. So --key=value, -key=value or key=value will all be split into two arguments
    # --key,value or -key,value or key,value
    #
    # input(s): an array of strings
    # output: an array of strings, by echoing it ${processed_args[@]}
    #
    # usage: local processed_args=($(common::splitArgs "${args[@]}"))
       
    local args=("$@")
    local arg=""
    local processed_args=()
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
    echo "${processed_args[@]}"
}