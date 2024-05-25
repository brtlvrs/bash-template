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