#!/bin/sh

# bangin - a primitive, portable shell script which enables DuckDuckGo-like bangs.
# Version: 0.1.1

input=${1}

search=${input%!*}

# Disallows no search text before bang
if [ -z "$search" ]; then exit 1; fi

bang_text=${input##*!}

# Disallows empty bang
if [ -z "$bang_text" ]; then exit 1; fi

# Disallows no bang
if [ "$bang_text" = "$input" ]; then exit 1; fi

bang="!$bang_text"

find_bang_in_file() {
    echo "$(sed -n "/^$bang /s/^$bang //p" "$1" 2> /dev/null)"
}

# Check user's config first
template=$(find_bang_in_file "${XDG_CONFIG_HOME:-$HOME/.config/bangin}/bangin.bangs")

# We need to check the files in reverse alphabetical order. The things we do
# for portability...
set -- "${XDG_DATA_HOME:-$HOME/.local/share}"/bangin/lists/*.bangs
i=$#
while [ $i -gt 0 ]; do
    if [ "$template" ]; then break; fi
    eval "file=\${$i}"
    template=$(find_bang_in_file "$file")
    i=$((i-1))
done

# No matching bang was found
if [ -z "$template" ]; then exit 1; fi

# From: https://unix.stackexchange.com/a/60698
urlencode () {
  string=$1
  while [ -n "$string" ]; do
    tail=${string#?}
    head=${string%$tail}
    case $head in
      [-._~0-9A-Za-z]) printf %c "$head";;
      *) printf %%%02x "'$head"
    esac
    string=$tail
  done
  echo
}

replaced=$(echo "$template" | sed "s/{{{s}}}/$(urlencode "$search")/")

echo "$replaced"

