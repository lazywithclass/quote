#!/bin/bash

wget -O - ftp://ftp.fu-berlin.de/pub/misc/movies/database/quotes.list.gz | gunzip -c >quotes.list
