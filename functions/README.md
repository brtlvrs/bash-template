# functions folder

|Folder|Purpose|
|:---|:---|
|functions|The base folder for all bash functions that needs to be sourced|

## script usage

``` bash
source functions/functions.sh
```

This script needs to be called at the start of the main script. It will source all bash files that are located in subfolders.
The script will determine its path location, and use this when calling it's private function.
When the private function is done, it will remove the private function from memory

## script functions

|function|file|Purpose|
|:---|:---|:---|
|[_source_functions](#_source_functions)|functions.sh|local /private function which is called by the script itself|

### _source_functions

A local/private function that scans all subfolders in the given path for bash files (ending on .sh) and sources them alphabeticly.
