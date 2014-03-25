#!/bin/sh
set -e


INPUT_FILENAME=$1

# replace .md with .html
OUTPUT_FILENAME=${INPUT_FILENAME%.md}.html

(
echo '<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <style type="text/css" source=''>'

cat `dirname $0`/swiss.css

sed 's/(\(.*\).md)/(\1.html)/g' $INPUT_FILENAME > .tmp.md


echo '</style></head><body>'
pandoc  -f markdown -t html .tmp.md
echo '</body></html>'
) > $OUTPUT_FILENAME