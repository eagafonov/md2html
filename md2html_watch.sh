#!/bin/sh
set -e
set -x


INPUT_FILENAME=$1

test -f $INPUT_FILENAME

WATCH_FILES=$INPUT_FILENAME

if test -f "style.css"; then
    WATCH_FILES=$WATCH_FILES style.css
fi

while (true); do 
    inotifywait --event close_write $WATCH_FILES || true;
    md2html.sh $INPUT_FILENAME
done
    
