#!/bin/bash
set -eu

RES=$(pwd)/.tools
[ $RES/vars.sh ] && . $RES/vars.sh

cd $1

cat << EOF > $RSSFILE
<?xml version="1.0" encoding="utf-8" ?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
	<channel>
		<title>$TITLE</title>
		<link>$BASEURL</link>
		<description>$DESCRIPTION</description>
		<lastBuildDate>$DATE</lastBuildDate>
EOF

for file in `find ./ -type f -not -name index.html -not -name .gitignore -not -name style.css -not -name rss -not -name Makefile -not -path "./.git/*" -not -path "./.tools/*"`; do
	name=${file##*/}
	path=${file#\./}
	category=$(echo $path | cut -f1 -d/)
	modified=$(date -Rr $file)
	cat << EOF >> $RSSFILE
		<item>
			<title>$name</title>
			<link>$BASEURL/$path</link>
			<category>$category</category>
			<pubDate>$modified</pubDate>
		</item>
EOF
done

cat << EOF >> $RSSFILE
	</channel>
</rss>
EOF
