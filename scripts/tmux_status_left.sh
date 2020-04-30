#!/bin/bash

width=100

branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
repo=$(git config --local remote.origin.url | cut -f2 -d: | cut -f1 -d. 2>/dev/null)
status=""


# Insert a random unicode char: Insert Mode -> ctrl-v -> u+<number>

if [ -n "$branch" ] ; then
    has_diff="  "
    if ! git diff-index --quiet HEAD -- ; then
        has_diff=" 繁"
    fi

    has_untracked="  "
    if [ -n "$(git ls-files --exclude-standard --others)" ] ; then
        has_untracked=" "
    fi

    status=" $(printf " %s  %s [%s%s ]" "$repo" "$branch" "$has_diff" "$has_untracked")   "
fi

status="  #S $status   $(dirs +0)"

printf "%*s" "-$width" "$status"
