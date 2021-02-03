_error()
{
    if [ $# -ne 2 ]
    then
        printf "Expected 1 argument to \`error\`, received %s.\\n" "$(( $# - 1 ))"
        exit 1
    fi

    local message
    message="$1"

    printf "ERROR: $1\\n" "$message" >&2
}


_warning()
{
    echo "$@"
    if [ $# -ne 2 ]
    then
        printf "Expected 1 argument to \`warning\`, received %s.\\n" "$(( $# - 1 ))"
        exit 1
    fi

    local message
    message="$1"

    printf "WARNING: %s\\n" "$message" >&2
}


##
# Get a user's response on a question to set environment variables.
response()
{
    if [ $# -lt 2 ]
    then
        _error "Must submit at least 2 arguments to \`response\` function for IO."
        exit 1
    elif [ $# -gt 3 ]
    then
        _warning "received $(( $# - 1 )) arguments at response function, ignoring extra arguments"
    fi

    question="$1"
    default="$2"

    read -r -p "$question" var
    if [ "$var" ]
    then
        printf "%s" "$var"
    else
        _warning "Defaulting to $default"
        printf "%s" "$default"
    fi

    return 0
}