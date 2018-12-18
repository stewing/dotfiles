#
# stewing@outlook.com bashrc
#

shopt -s checkwinsize
shopt -s execfail
shopt -s hostcomplete
shopt -s extglob

OS=`uname -s`

#
# path utilities
alias realpath="perl -MCwd -e 'print Cwd::realpath(shift()).\"\\n\";'"

#
# numbers, bases
alias hex='printf "0x%08x\n"'
alias dec='printf "%d\n"'
alias bin="perl -e 'printf(\"%b\n\", shift());'"

#
# Spaces, text, etc.
#
alias noblanks="sed '/^\s*$/d'"
alias oneline="tr '\n' ' '"
alias uc="tr '[:lower:]' '[:upper:]'"
alias lc="tr '[:upper:]' '[:lower:]'"
alias trimwsr="find . -type f | xargs sed -i 's/[ \\t]*$//'"
alias bracketed_paste_off='printf "\e[?2004l"'

function strlen
{
    str=$1
    echo ${#str}
}

function rand_str
{
    local len=$1
    if [ -z "$len" ] ; then
        len=10
    fi
    cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c $len
}

function rand_no
{
    local ceil=10
    if [ ! -z $1 ] ; then
        ceil=$1
    fi
    local myrand=$(($RANDOM % $ceil))
    printf "%d\n" $myrand
    return $myrand
}

export -f strlen rand_str rand_no

# size
alias hr="perl -e 'my \$inp = shift; my (\$s, \$v); \$v = 1; \$inp=~s/,//g; if (\$inp >= 1073741824) {\$s = 'GB', \$v = 1073741824;} elsif (\$inp >= 1048576) { \$s = 'MB';\$v = 1048576 } elsif (\$inp >= 1024) { \$s = 'KB'; \$v = 1024} printf(\"%0.2f%s\\n\", \$inp/\$v, \$s);'"
function k()
{
    echo "$1*1024" | bc
}
function m()
{
    echo "$1*1024^2" | bc
}
function g()
{
    echo "$1*1024^3" | bc
}

export -f k m g

# time
alias gmtime="perl -e '\print scalar(gmtime(shift())), \"\n\";'"
alias grep="grep --color"
alias timestamp="gawk '{ print strftime(\"%Y-%m-%d %H:%M:%S\"), \$0; fflush(); }'"

function epochtime {
    if [ -t 0 ] ; then
        seconds="$1"
    else
        seconds=$(cat)
    fi
    if [ -z "$seconds" ] ; then
        echo "Usage: $0 <epoch_seconds>"
        echo "       echo <epoch_seconds> | $0"
        return 1
    fi
    case "$OS" in
        Darwin)
            date -r "$seconds"
            ;;
        Linux)
            date --date "@$seconds" --utc
            ;;
        *)
            echo "Unknown OS: \"$OS\""
            ;;
    esac
}

function now() {
    if [ $# -gt 0 ] ; then
        ARGS=$@
        date -u +"%Y-%m-%dT%TZ" -d "$ARGS"
    else
        date -u +"%Y-%m-%dT%TZ"
    fi
}

export -f epochtime now

# weather
alias weather="curl -s wttr.in/Pittsburgh"

# Misc stuff
alias agp='ag --pager "less -R"'
alias addrs="ip -o a | cut -d ' ' -f2,7"
alias jpp="python -mjson.tool"

function grepN
{
    lines=$1
    if [ -z "$2" ] ; then
        echo "Need a pattern"
        return 1
    fi
    pattern="$2"
    (head -n$lines ; grep $pattern)
}

function grep1
{
    grepN 1 $@
}
function grep2
{
    grepN 2 $@
}
function grep3
{
    grepN 3 $@
}
function grep4
{
    grepN 4 $@
}

export -f grep{1..4}

function colors_dark
{
    LS_COLORS="di=94:fi=0:ln=91:pi=4;35:so=5;35:bd=4;34:cd=4;31:or=4;32:mi=4;95:ex=92"
}

# cdexec (PROMPT_COMMAND)
function __cdexec
{
    if [ -x .cdexec ] ; then
        file=`realpath .cdexec`
        if [ `stat -c %A $file | cut -c6` == "-" ] && \
            [ `stat -c %A $file | cut -c9` == "-" ] && \
            [ `stat -c %U $file` == $USER ]  ; then
            . .cdexec
        fi
    fi
}

function __write_history
{
    LAST_EXIT_STATUS=$?
    [ -d "$HISTDIR" ] || mkdir "$HISTDIR"
    echo "$(hostname -s) $(pwd) $(history 1)" >> $HISTDIR/bash_history_$(date "+%Y-%m-%d").log
    ln -sf $HISTDIR/bash_history_$(date "+%Y-%m-%d").log ~/.history/today.log
}

function __set_vars
{
    GIT_BRANCH=""
    GIT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null)
    ABBREV_DIRS=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}")
}

function __set_it2_tb
{
    IT2TB="$HOME/.iterm2/it2setkeylabel"
    if [ -x $IT2TB ] ; then
        if [ -z "$GIT_BRANCH" ] ; then
            TB_GIT_BRANCH=""
        else
            TB_GIT_BRANCH="⌥ $GIT_BRANCH"
        fi

        if [ ${#PWD} -gt 40 ] ; then
            TB_CWD="🧭 $ABBREV_DIRS"
        else
            TB_CWD="🧭 $PWD"
        fi

        if [ "$LAST_EXIT_STATUS" == "0" ] ; then
            TB_LAST=""
        else
            TB_LAST="(╯°□°）╯︵ ┻━┻"
            #TB_LAST="ಠ__ಠ"
        fi

        if [ $(date +"%H") -gt 12 ]; then
            TB_BEV="🍺"
        else
            TB_BEV="☕️"
        fi

        $IT2TB set status "$TB_BEV   $TB_GIT_BRANCH   $TB_CWD    $TB_LAST"
    fi
}

# settings
EDITOR=vim
GIT_EDITOR=$EDITOR
PS1="\h % "
PAGER="less"
FIGNORE=".o:~"
MAKEFLAGS="-j 4"
if [ -e /proc/cpuinfo ] ; then
    MAKEFLAGS="-j $(grep -c ^processor /proc/cpuinfo)"
fi
DIFF="vimdiff -R"

# history
shopt -s histappend
HISTIGNORE=" *:ll:ll *:[bf]g:exit:history:history *:bc"
HISTTIMEFORMAT="%Y-%m-%d-%T "
HISTSIZE=5000
HISTDIR="$HOME/.history"

function ht
{
    sval="$1"
    if [ -z "$sval" ] ; then
        echo "need regex to search"
        return 1
    fi
    grep --no-filename "$sval" "$HISTDIR/today.log" | cut -d' ' -f7- | sort | uniq
}

function hs
{
    sval="$1"
    if [ -z "$sval" ] ; then
        echo "need regex to search"
        return 1
    fi
    grep --no-filename "$sval" "$HISTDIR/"* | cut -d' ' -f7- | sort | uniq
}

# P4
alias openlist="p4 opened | sed 's/#.*//' | p4 -x - where | awk '/^\// {print \$3}'"
P4CONFIG=Perforce
P4EDITOR=vim
P4DIFF="vimdiff -R"

export P4CONFIG P4EDITOR P4DIFF

# git
function git_repos
{
    find $PWD -name .git -print | xargs -L1 dirname
}

function git_changed
{
    git diff --name-only|xargs -r -L1 realpath |oneline
}

function git_changed_rec
{
    my_pwd=$PWD
    for git_dir in `git_repos` ; do
        cd "$git_dir"
        git_changed
        cd "$my_pwd"
    done
}
alias vimch="vim -O3 \`git_changed_rec\`"

# set up interactive vs. non-interactive stuff...
case $- in
    *i*)    # interactive shell
        case $OS in
            Linux)
                true
                ;;
            Darwin)
                PATH=$PATH:/usr/local/bin/
                launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist &> /dev/null
                export CLICOLOR=1
                # DYLD_FALLBACK_LIBRARY_PATH=
                ;;
            FreeBSD)
                true
                ;;
            *)
                ;;
        esac

        # Detailed command history
        if [ ! -d "$HISTDIR" ] ; then
            mkdir "$HISTDIR"
        fi

        PROMPT_COMMAND="__write_history; __set_vars; __set_it2_tb"

        BASE16_SHELL=$HOME/.config/base16-shell/
        [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
    ;;
    *)      # non-interactive shell
    ;;
esac

export PAGER HISTSIZE HISTIGNORE HISTTIMEFORMAT FIGNORE PS1 EDITOR ABBREV_DIRS GIT_EDITOR GIT_BRANCH PROMPT_COMMAND MAKEFLAGS LAST_EXIT_STATUS

# functions
function prefix {
    sed -e "s/^/$1: /"
}

# completion
COMPLETION_FILE=/fs/home/sewing/git/bash-completion/bash_completion
if [ -x $COMPLETION_FILE ] ; then
    . $COMPLETION_FILE
fi

# ascii conversion array

ascii_array=(nul soh stx etx eot enq ack bel bs  ht  nl  vt  np  cr  so  si dle dc1 dc2 dc3 dc4 nak syn etb can em sub esc fs gs rs us sp \! \" \# \$ \% \& \' \( \) \* + , - . / 0 1 2 3 4 5 6 7 8 9 : \; \< = \> ?  @ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z \[ \\ \] ^ _ \` a b c d e f g h i j k l m n o p q r s t u v w x y z \{ \| \} ~ del)

function itoa {
    echo ${ascii_array[$1]}
}

export -f itoa rand_str strlen rand_no k m g

compgen -G "$HOME/.bashrc.*" > /dev/null
rc=$?
if [ "$rc" -eq 0 ] ; then
    for rc in $HOME/.bashrc.* ; do
        source "$rc"
    done
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

