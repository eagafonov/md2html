#!/bin/sh
set -e

INPUT_FILENAME=$1

BASE_NAME=$(grep '<!---md2html:' $INPUT_FILENAME | head -1|sed 's/^<!---md2html:\(.*\)--->/\1/')

if [ -z "$BASE_NAME" ]; then
    BASE_NAME=${INPUT_FILENAME%.md}
fi

# replace .md with .html
OUTPUT_FILENAME=${BASE_NAME}.html

echo "OUTPUT_FILENAME=$OUTPUT_FILENAME"

(
echo '<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <style type="text/css" source=''>'

    
cat $(dirname $(readlink $0))/swiss.css

sed 's/(\(.*\).md)/(\1.html)/g' $INPUT_FILENAME > .tmp_md

echo '</style></head><body>'
pandoc  -f markdown -t html .tmp_md
echo '</body></html>'
) > $OUTPUT_FILENAME