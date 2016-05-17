#!/bin/bash

filename=quotes.list

function textat() {
    local from=$1
    local to=$1
    if [[ ! -z "$2" ]]; then
        to=$2
    fi
    echo "$(sed -n $(($from)),${to}p $filename)"
}

function seekpreviousempty() {
    local line=$1
    local linetext=$(textat $line)
    if [[ -z $linetext ]]; then
        echo $line
    else
        seekpreviousempty $(($line-1))
    fi
}

function seeknextempty() {
    local line=$1
    local linetext=$(textat $line)
    if [[ -z $linetext ]]; then
        echo $line
    else
        seeknextempty $(($line+1))
    fi
}

function istitle() {
    local line=$1
    if echo "$line" | grep '^#' &>/dev/null; then
        return 0
    else
        return 1
    fi
}

function seektitle() {
    local line="$1"
    local linetext=$(textat "$line")
    if istitle "$linetext"; then
        echo "$line"
    else
        seektitle $(($line-1))
    fi
}

lines=$(wc -l <$filename | tr -d ' ')
randomline=$(gshuf -i 0-$lines -n 1)
randomlinetext=$(textat $randomline)

textat "$(seektitle $(($randomline+1)))"
if [[ -z $randomlinetext ]]; then
    textat $(($randomline+1)) $(seeknextempty $(($randomline+1)))
else
    textat $(($(seekpreviousempty $randomline)+1)) $(seeknextempty $randomline)
fi

# TODO
# find a name, commit push and add these as issues
# handle case in which the random line is the title of the movie (it ends up printed just that)
# refactor the two seek functions into one
# add the name of the movie to each text
# slooooooow
