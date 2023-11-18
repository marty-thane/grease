#!/bin/bash
set -eu

get_emoji() {
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


root=$(pwd)
res=$(pwd)/.tools
[ $res/vars.sh ] && . $res/vars.sh

cd $1
for dir in `find $(pwd) -type d -name "[!.]*"`; do
	if [[ "$dir" == *"/."* ]]; then
        echo "Skipping hidden: $dir"
        continue
    fi

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
	<!-- <link rel="icon" type="image/x-icon" href="$BASEURL/icon.ico"> -->
	<title>$TITLE</title>
</head>
<body>
	<h1>$TITLE</h1>
EOF

	for item in `find -maxdepth 1 -not -name ".*" -type d | sort` `find -maxdepth 1 -not -name ".*" -type f | sort`; do
		item=${item#\./}
		if [[ ! " ${IGNORED_FILES[@]} " =~ " $item " ]]; then
			cat << EOF >> $HTMLFILE
	<a href="$BASEURL${dir/$root/}/$item">$(get_emoji $item)$item</a><br>
EOF
		else
			echo "excluding: $item"
		fi
	done

	cat << EOF >> $HTMLFILE
	<hr>
	<p class="notice">
		© 2023 $AUTHOR
		<span class="right">
		<a href="$BASEURL/rss">rss</a>
		<a href="mailto:$CONTACT">kontakt</a>
		</span>
	</p>
</body>
</html>
EOF

done
