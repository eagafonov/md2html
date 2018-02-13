#!/bin/sh
set -e
set -x

INPUT_FILENAME=$1

BASE_NAME=$(grep '<!---md2html:' $INPUT_FILENAME | head -1|sed 's/^<!---md2html:\(.*\)--->/\1/')

if [ -z "$BASE_NAME" ]; then
    BASE_NAME=${INPUT_FILENAME%.md}
fi

# replace .md with .html
OUTPUT_FILENAME=${BASE_NAME}.html
TMP_MD=.tmp-${BASE_NAME}-md


echo "OUTPUT_FILENAME=$OUTPUT_FILENAME"

if [ -f 'style.css' ]; then
    STYLE_CSS='style.css'
else
    STYLE_CSS=$(dirname $(readlink -m $0))/swiss.css
fi

echo "style: $STYLE_CSS"

(
echo '<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <style type="text/css" source=''>'

cat ${STYLE_CSS}

sed 's/(\(.*\).md)/(\1.html)/g' $INPUT_FILENAME > $TMP_MD

echo '</style></head><body>'
pandoc  -f markdown -t html $TMP_MD
echo '</body></html>'
) > $OUTPUT_FILENAME
