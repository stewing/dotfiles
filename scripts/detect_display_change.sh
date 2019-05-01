#!/bin/bash

displays_file="/tmp/displays.txt"
new_displays_file="/tmp/displays_$$.txt"

display_change_script="$HOME/.chunkwmrc"

system_profiler SPDisplaysDataType | awk '/Display Type:/{print x}; {x=$0}' | sed -e 's/^ *//g;s/://g' > "$new_displays_file"

if [ ! -e "$displays_file" ] ; then
    mv "$new_displays_file" "$displays_file"
    exit 0
fi

cmp "$new_displays_file" "$displays_file"

if [ "$?" != "0" ] ; then
    if [ -x "$display_chnage_script" ] ; then
        source "$display_change_script"
    fi
fi


mv "$new_displays_file" "$displays_file"

exit 0
