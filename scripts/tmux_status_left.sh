#!/bin/bash

width=100

branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
repo=$(basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null)

status=""

if [ -n "$branch" ] ; then
    status=$(printf " %s  %s" "$repo" "$branch")
else
    status=$(printf " %s  %s" "-" "-")
fi

status="$status    $(dirs +0)"

printf "%*s" "-$width" "$status"
