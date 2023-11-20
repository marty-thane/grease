#!/bin/bash
set -eu

if [ -f ./vars.sh ]; then
	source ./vars.sh
else
	echo "vars.sh: not found"
	exit
fi

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

for item in $(find -type f); do
	name=${item##*/}
	path=${item#\./}
	category=$(echo $path | cut -f1 -d/)
	modified=$(date -Rr $item)
	if [[ "$item" == *"/."* ]]; then
		echo "skipping hidden: $name"
		continue
	fi
	if [[ " ${IGNORED_FILES[@]} " =~ " $name " ]]; then
		echo "skipping ignored: $name"
		continue
	fi
	cat << EOF >> $RSSFILE
		<item>
			<title>$name</title>
			<link>$BASEURL/$path</link>
			<pubDate>$modified</pubDate>
EOF
	if [[ "$name" != "$category" ]]; then
		cat << EOF >> $RSSFILE
			<category>$category</category>
EOF
	fi
	cat << EOF >> $RSSFILE
		</item>
EOF
done

cat << EOF >> $RSSFILE
	</channel>
</rss>
EOF

