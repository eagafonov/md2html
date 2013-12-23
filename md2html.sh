#!/bin/sh
set -e

(
echo '<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <style type="text/css" source=''>'

cat `dirname $0`/swiss.css

echo '</style></head><body>'
pandoc  -f markdown -t html $1
echo '</body></html>'
) > $1.html