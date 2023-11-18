#!/bin/bash
set -eu

print_emoji() {
	file_type=$(file -b "$1")
	case "$file_type" in
		*PDF*) echo "📖";;
		*audio*) echo "🎧";;
		*Media*) echo "🎬";;
		*image*) echo "🖼️";;
		*text*) echo "📄";;
		*directory*) echo "📁";;
		*executable*) echo "🚀";;
		*compressed*) echo "📦";;
		*) echo "❓";;
	esac
}

if [ -f ./vars.sh ]; then
	source ./vars.sh
else
	echo "vars.sh: not found"
	exit
fi

cd $1
root=$(pwd)

for dir in $(find $root -type d -not -path "$root/.*" -not -name ".*"); do
	cd $dir
	cat << EOF > $HTMLFILE
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="generator" content="tree" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="author" content="$AUTHOR" />
	<link rel="stylesheet" href="$BASEURL/style.css" />
	<link rel="alternate" type="application/rss+xml" title="$TITLE" href="$BASEURL/$RSSFILE"/>
	<!-- <link rel="icon" type="image/x-icon" href="$BASEURL/icon.ico"> -->
	<title>$TITLE</title>
</head>
<body>
	<h1>$TITLE</h1>
EOF

	for item in $(find ./ -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort) \
		$(find ./ -maxdepth 1 -mindepth 1 -type f -exec basename {} \; | sort); do
	    if [[ "$item" == .* ]]; then
	        echo "skipping hidden: $item"
	        continue
	    fi
	    if [[ " ${IGNORED_FILES[*]} " =~ " $item " ]]; then
	        echo "skipping ignored: $item"
	        continue
	    fi

		cat << EOF >> $HTMLFILE
	<a href="$BASEURL${dir/$root/}/$item">$(print_emoji $item)$item</a><br>
EOF
	done

	cat << EOF >> $HTMLFILE
	<hr>
	<p class="notice">
		© 2023 $AUTHOR
		<span class="right">
		<a href="$BASEURL/$RSSFILE">rss</a>
		<a href="mailto:$CONTACT">kontakt</a>
		</span>
	</p>
</body>
</html>
EOF

done
