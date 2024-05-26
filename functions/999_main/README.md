# 999_main

|Folder|Purpose|
|:---|:---|
|999_main|function files for main script routine|

# functions

|function|file|Purpose|
|:---|:---|:---|
|[_banner](#_banner)|banner.sh|Displays a banner
[_usage](#_usage)|usage.sh|Displays the usage or help message|
[_guardrails](#_guardrails)|guardrails.sh|Guardrails for script
[_processArgs](#_processargs)|processArgs.sh|Routine to process script arguments

## _banner

This displays the brtlvrs banner

### usage

``` bash
_banner
```

Yes sometines it is that simple

## _usage

This function displays the help message when the script is called with option -h or --help.   
It is also called when a unknown and/or invalid argument is passed to the script.

### arguments

none

### result

none

### example

``` bash
_usage
```

## _guardrails

This is the guardrails function for the script   
When a guardrail is triggered / hit, it will display a warning and returns with status 1.
When no guardrail is hit, it will return status 0.

### usage

``` bash
_guardrails "$@" || exit 1
```
|||
|---|---|
|```$@```| passes all arguments to the _guardrails function|
|```\|\|```| OR call when the _guardrails function returns with status 1 (this happens when a guardrail is hit)|
|```exit 1```|exit the script with status/error code 1|

## _processArgs

Proces script arguments.

### usage

``` bash
_processArgs "$@" || exit 1
```
|||
|---|---|
|```$@```| passes all arguments to the _guardrails function|
|```\|\|```| OR call when the  function returns with status 1|
|```exit 1```|exit the script with status/error code 1|
