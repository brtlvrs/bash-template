# _common

|Folder|Purpose|
|:---|:---|
|_common|common functions|

# functions

|function|file|Purpose|
|:---|:---|:---|
|[helloWorld](#helloWorld)|helloWorld.sh|The famous Hello World function|
|[splitArgs](#splitArgs)|splitArgs.sh|Proces an array of strings, and splitting key=value into two arguments

## helloWorld

This functions displays 'Hello World' when called

### usage

``` bash
common::helloWorld
```

Yes sometines it is that simple

## splitArgs

This function process all arguments that are given to it and returns a new arrray of strings where
arguments that are formatted as key=value will be split into two arguments key and value

### splitArgs usage

``` bash
local args=("$@")
local processed_args=($(common::splitArgs "${args[@]}"))
```
