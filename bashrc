#
# stewing@outlook.com bashrc
#

shopt -s checkwinsize
shopt -s execfail
shopt -s hostcomplete
shopt -s extglob

# path utilities
alias realpath="perl -MCwd -e 'print Cwd::realpath(shift()).\"\\n\";'"

# numbers, bases
alias hex='printf "0x%08x\n"'
alias dec='printf "%d\n"'
alias bin="perl -e 'printf(\"%b\n\", shift());'"

# strings, etc

function strlen {
    str=$1
    echo ${#str}
}

function rand_str {
    local len=$1
    if [ -z "$len" ] ; then 
        len=10 
    fi
    cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c $len
}

function rand_no {
    local ceil=10
    if [ ! -z $1 ] ; then
        ceil=$1
    fi
    local myrand=$(($RANDOM % $ceil))
    printf "%d\n" $myrand
    return $myrand
}

# size
alias hr="perl -e 'my \$inp = shift; my (\$s, \$v); \$v = 1; \$inp=~s/,//g; if (\$inp >= 1073741824) {\$s = 'GB', \$v = 1073741824;} elsif (\$inp >= 1048576) { \$s = 'MB';\$v = 1048576 } elsif (\$inp >= 1024) { \$s = 'KB'; \$v = 1024} printf(\"%0.2f%s\\n\", \$inp/\$v, \$s);'"
function k() {
    echo "$1*1024" | bc
}
function m() {
    echo "$1*1024^2" | bc
}
function g() {
    echo "$1*1024^3" | bc
}

# time
# alias date='date +"%A %B %e %r"'
alias rt_ms="perl -n -e 'printf \"%02dh%02dm%02ds\\n\",(gmtime(\$_/1000))[2,1,0];'"
alias rt_us="perl -n -e 'printf \"%02dh%02dm%02ds\\n\",(gmtime(\$_/1000))[2,1,0];'"
alias gmtime="perl -e '\print scalar(gmtime(shift())), \"\n\";'"
alias grep="grep --color"
alias timestamp="gawk '{ print strftime(\"%Y-%m-%d %H:%M:%S\"), \$0; fflush(); }'"

# weather
alias weather="curl -s wttr.in/Pittsburgh"

# other utilities
alias noblanks="sed '/^\s*$/d'"
alias agp='ag --pager "less -R"'
alias addrs="ip -o a | cut -d ' ' -f2,7"
alias uc="tr '[:lower:]' '[:upper:]'"
alias lc="tr '[:upper:]' '[:lower:]'"

function grep1 {
    alias grep1="awk 'NR==1 || /$1/'"
}

function colors_dark {
    LS_COLORS="di=94:fi=0:ln=91:pi=4;35:so=5;35:bd=4;34:cd=4;31:or=4;32:mi=4;95:ex=92"
}



# cdexec (PROMPT_COMMAND)
function cdexec {
    if [ -x .cdexec ] ; then 
        file=`realpath .cdexec`
        if [ `stat -c %A $file | cut -c6` == "-" ] && \
            [ `stat -c %A $file | cut -c9` == "-" ] && \
            [ `stat -c %U $file` == $USER ]  ; then
            . .cdexec
        fi
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
HISTDIR="$HOME/.history"

# history
shopt -s histappend
HISTIGNORE=" *:ll:ll *:[bf]g:exit:history:history *:bc"
HISTTIMEFORMAT="%Y-%m-%d-%T "
HISTSIZE=5000

# P4
alias openlist="p4 opened | sed 's/#.*//' | p4 -x - where | awk '/^\// {print \$3}'"
P4CONFIG=Perforce
P4EDITOR=vim
P4DIFF="vimdiff -R"

export P4CONFIG P4EDITOR P4DIFF

# set up interactive vs. non-interactive stuff...
case $- in
    *i*)    # interactive shell
    if [ `uname -s` == "Linux" ] ; then 
        true
    fi
    if [ `uname -s` == "Darwin" ] ; then 
        PATH=$PATH:/net/nfs.paneast.panasas.com/sb31/sewing/macos/homebrew/bin
        DYLD_FALLBACK_LIBRARY_PATH=/net/nfs.paneast.panasas.com/sb31/sewing/macos/homebrew/lib
        #DYLD_FALLBACK_LIBRARY_PATH=/net/nfs.paneast.panasas.com/home/sewing/git/homebrew/lib
        launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist &> /dev/null
    fi
    if [ ! -d "$HISTDIR" ] ; then
        mkdir "$HISTDIR"
    fi
    if [ `uname -s` == 'FreeBSD' ] ; then 
        true
        # PROMPT_COMMAND='echo foo'
    else
        PROMPT_COMMAND='echo "$(hostname -s) $(pwd) $(history 1)" >> $HISTDIR/bash_history_$(date "+%Y-%m-%d").log'
    fi
    ;;
    *)      # non-interactive shell
    ;;
esac

export PAGER HISTSIZE HISTIGNORE HISTTIMEFORMAT FIGNORE PS1 EDITOR GIT_EDITOR PROMPT_COMMAND MAKEFLAGS

# functions

function epochtime {
    \date --date @$1 --utc
}

function prefix {
    sed -e "s/^/$1: /"
}

# completion
COMPLETION_FILE=/fs/home/sewing/git/bash-completion/bash_completion
if [ -x $COMPLETION_FILE ] ; then
    . $COMPLETION_FILE
fi

PYTHONPATH=/System/Library/Frameworks/Python.framework

# git prompt integration
#GIT_PROMPT_INTEGRATION=~/git/bash-git-prompt/gitprompt.sh
#if [ -x $GIT_PROMPT_INTEGRATION ] ; then
#    . $GIT_PROMPT_INTEGRATION
#fi

# ascii conversion array

ascii_array=(nul soh stx etx eot enq ack bel bs  ht  nl  vt  np  cr  so  si dle dc1 dc2 dc3 dc4 nak syn etb can em sub esc fs gs rs us sp \! \" \# \$ \% \& \' \( \) \* + , - . / 0 1 2 3 4 5 6 7 8 9 : \; \< = \> ?  @ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z \[ \\ \] ^ _ \` a b c d e f g h i j k l m n o p q r s t u v w x y z \{ \| \} ~ del)

function itoa {
	echo ${ascii_array[$1]}
}

export -f itoa rand_str strlen rand_no k m g 

# host-specific stuff
case `hostname -s` in 
    sewing-mbp)
        alias sudo=/usr/bin/sudo
        ;;
    *)
        ;;
esac
