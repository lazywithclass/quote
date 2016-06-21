#!/bin/bash

films=$(ls quotes-by-film | wc -l | tr -d ' ')
randomfilm=$(gshuf -i 1-$films -n 1)
quotes=$(ls quotes-by-film/$randomfilm | wc -l | tr -d ' ')
randomquote=$(gshuf -i 1-$quotes -n 1)

cat quotes-by-film/$randomfilm/$randomquote


# TODO
# find a name, commit push and add these as issues
# add a script that checks if we have to download a more recent version of the quotes