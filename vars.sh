#!/bin/bash

TITLE="Your Website"
AUTHOR="John Doe"
CONTACT="john.doe@example.com" # email address
DESCRIPTION="my personal website"
BASEURL="https://example.com" # your domain
HTMLFILE="index.html"
RSSFILE="rss"
DATE=$(date -R) # used for copyright and lastBuildDate, do not edit
IGNORED_FILES=( $HTMLFILE $RSSFILE "style.css" ) # here you can specify files to exclude from being indexed
