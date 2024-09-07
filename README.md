Grease
======
This repository contains Bash scripts for generating my personal website. They
are intended for file repositories (i.e., not meant for blogs, etc.).
The scripts create index files and an RSS feed, offering customization through
a configuration file.

Usage
-----
1. Edit the `vars.sh` file to personalize your website. This includes filling
   in details such as domain, author, and contact email.
2. Run the HTML index generator script on the location containing your file
   repository. For example:

       bash html.sh public/

   This will generate an index file in the specified directory (`public/`) and
   each of its subdirectories.
3. Run the RSS feed generator script in a similar manner:

       bash rss.sh public/

   The RSS file will be stored at the root of the specified directory.

Notes
-----
- If emojis are not generating properly on some files, check the output of
  `file -b <file>` against the `print_emoji()` function in `html.sh`. Manually
  add the missing icon for the file type in question.
- Specify files to exclude from indexing in `vars.sh`. This typically includes
  index files, the RSS file, CSS file, and website icons.

Example
-------
You can visit [my personal website](https://marty-thane.github.io) for a live
demo.
