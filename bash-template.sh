#!/bin/bash
source ./functions/functions.sh

#-- MAIN routine
main::_banner
main::_guardrails "$@" || exit 1
main::_procesArgs "$@" || exit 1

# let's run a test demo
demo::test