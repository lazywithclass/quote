#/bin/bash


function istitle() {
    local line=$1
    if echo "$line" | grep '^#' &>/dev/null; then
        return 0
    else
        return 1
    fi
}

function isempty() {
    local line=$1
    if echo "$line" | grep '^$' &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# delete header
sed '0,/^=============$/d' quotes.list >quotes.list.used

lineread=0
filmcounter=0
quotecounter=1
lasttitle=''
while read line; do
    lineread=$((lineread+1))
    echo $lineread

    if istitle $line; then
        lasttitle=$line
        filmcounter=$((filmcounter+1))
        quotecounter=1
        mkdir quotes-by-film/$filmcounter
        echo $lasttitle >quotes-by-film/$filmcounter/$quotecounter
        continue
    fi

    if isempty "$line"; then
        quotecounter=$((quotecounter+1))
        read line
        if isempty "$line"; then
            continue
        else
            echo $lasttitle >quotes-by-film/$filmcounter/$quotecounter
            echo $line >>quotes-by-film/$filmcounter/$quotecounter
            continue
        fi
    fi

    echo $line >>quotes-by-film/$filmcounter/$quotecounter
done<quotes.list.used
