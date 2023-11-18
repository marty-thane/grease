#!/bin/bash

TITLE="Your Website"
AUTHOR="John Doe"
CONTACT="john.doe@example.com"
DESCRIPTION="my personal website"
BASEURL="https://example.com"
HTMLFILE="index.html"
RSSFILE="rss"
DATE=$(date -R)
IGNORED_FILES=( $HTMLFILE $RSSFILE "style.css" )
