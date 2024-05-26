main::_guardrails(){
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