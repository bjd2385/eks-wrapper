#! /bin/bash

##
# Print an error message to stderr.
_error()
{
    if [ $# -ne 1 ]
    then
        printf "Expected 1 argument to \`_error\`, received %s.\\n" "$#" >&2
        exit 1
    fi

    local message
    message="$1"

    printf "\e[2m\e[1mERROR\e[0m\e[2m: %s\e[0m\\n" "$message" >&2
}


##
# Print a warning message to stderr.
_warning()
{
    if [ $# -ne 1 ]
    then
        _error "Expected 1 argument to \`_warning\`, received $#.\\n"
    fi

    local message
    message="$1"

    printf "\e[2m\e[1mWARNING\e[0m\e[2m: %s\e[0m\\n" "$message" >&2
}


##
# Print the equivalent of a white-text header/separator.
_separator()
{
    if [ $# -ne 1 ]
    then
        _error "Expected 1 argument to \`_separator\`, received $#.\\n"
    fi

    local message
    message="$1"

    printf "\\n\e[1m%s\e[0m\\n\\n" "$message"

    return 0
}


_wait()
{
    if [ $# -ne 1 ]
    then
        printf "Expected 1 argument to \`_wait\`, received %s.\\n" "$#"
        exit 1
    fi

    local wait_time
    wait_time="$1"

    for _ in $(seq 1 "$wait_time")
    do
        printf "..."
        sleep 1
    done
    printf " should be good to go now!\\n"
}


##
# Get a user's response on a question to set environment variables.
response()
{
    if [ $# -eq 0 ]
    then
        _error "Must submit at least 2 arguments to \`response\` function for IO."
        exit 1
    elif [ $# -gt 2 ]
    then
        _warning "received >2 arguments at response function, ignoring extra arguments"
    fi

    question="$1"
    default="$2"

    read -r -p "$question" var
    if [ "$var" ]
    then
        printf "%s" "$var"
    else
        if [ "$default" ]
        then
            _warning "Defaulting to $default"
        else
            _warning "Attempted to default, but no value given, returning \"\""
        fi
        printf "%s" "$default"
    fi

    return 0
}
