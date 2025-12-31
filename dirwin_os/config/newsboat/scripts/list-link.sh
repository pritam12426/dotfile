#!/bin/sh

# Pipe the article's rendered text (with numbered links) to extract URLs
# Newsboat pipes the text to stdin when using pipe-to

# Extract URLs (Newsboat numbers them like [1]: https://...)
grep -E -o "(mailto|ftp|http(s)?://){1}[^'\"]+" |
nl -w2 -s': ' |  # Pretty numbering
fzf --ansi --prompt="Select link: " --height=20 |
cut -d: -f2- | tr -d ' ' |  # Get the URL
xargs -r open -a firefox   # Replace with your action: xargs -r xclip -sel clip  (copy to clipboard)
#                 # or xargs -r firefox     (open in browser)
#                 # or just print for now
