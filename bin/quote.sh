#!/bin/bash

script=$(realpath $0)
path=$(dirname $script)

films=$(ls $path/../quotes-by-film | wc -l | tr -d ' ')
randomfilm=$(gshuf -i 1-$films -n 1)
quotes=$(ls $path/../quotes-by-film/$randomfilm | wc -l | tr -d ' ')
randomquote=$(gshuf -i 1-$quotes -n 1)

cat $path/../quotes-by-film/$randomfilm/$randomquote
