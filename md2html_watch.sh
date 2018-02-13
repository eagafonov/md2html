#!/bin/sh
set -e
set -x


INPUT_FILENAME=$1

test -f $INPUT_FILENAME

while (true); do 
    inotifywait --event close_write $INPUT_FILENAME style.css || true;
    md2html.sh $INPUT_FILENAME
done
    
