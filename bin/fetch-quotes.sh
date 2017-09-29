#!/bin/bash

wget -O - ftp://ftp.fu-berlin.de/pub/misc/movies/database/temporaryaccess/quotes.list.gz | gunzip -c >quotes.list
