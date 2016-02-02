#
# stewing@outlook.com bashrc
#

shopt -s checkwinsize
shopt -s execfail
shopt -s hostcomplete

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

# time
alias date='date +"%A %B %e %r"'
alias rt_ms="perl -n -e 'printf \"%02dh%02dm%02ds\\n\",(gmtime(\$_/1000))[2,1,0];'"
alias rt_us="perl -n -e 'printf \"%02dh%02dm%02ds\\n\",(gmtime(\$_/1000))[2,1,0];'"
alias gmtime="perl -e '\print scalar(gmtime(shift())), \"\n\";'"
alias grep="grep --color"
alias timestamp="awk '{ print strftime(\"%Y-%m-%d %H:%M:%S\"), \$0; fflush(); }'"

# other utilities
alias noblanks="sed '/^\s*$/d'"
alias agp='ag --pager "less -R"'

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
HISTIGNORE=" *:ll:ll *:[bf]g:exit:history:history *:bc"
FIGNORE=".o:~"
MAKEFLAGS="-j $(grep -c ^processor /proc/cpuinfo)"

# P4
P4CONFIG=Perforce
P4EDITOR=vim
P4DIFF=vimdiff
alias openlist="p4 opened ...| ack '.*(src.*)#' --output='\$1'"

# set up interactive vs. non-interactive stuff...
case $- in
    *i*)    # interactive shell
    if [ `uname -s` == "Linux" ] ; then 
        PROMPT_COMMAND=
    fi
    ;;
    *)      # non-interactive shell
    ;;
esac

export PAGER HISTIGNORE FIGNORE PS1 EDITOR GIT_EDITOR PROMPT_COMMAND MAKEFLAGS

# functions

function epochtime {
    \date --date @$1 --utc
}

# completion
COMPLETION_FILE=/fs/home/sewing/git/bash-completion/bash_completion
if [ -x $COMPLETION_FILE ] ; then
    . $COMPLETION_FILE
fi


# git prompt integration
#GIT_PROMPT_INTEGRATION=~/git/bash-git-prompt/gitprompt.sh
#if [ -x $GIT_PROMPT_INTEGRATION ] ; then
#    . $GIT_PROMPT_INTEGRATION
#fi
