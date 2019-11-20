#!/bin/sh
set -e
set -x


INPUT_FILENAME=$1
test -f $INPUT_FILENAME

WATCH_FILES=$INPUT_FILENAME

while (true); do 
    inotifywait --event close_write $WATCH_FILES || true;
    plantuml $INPUT_FILENAME || true
done

