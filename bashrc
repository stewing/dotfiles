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

export PAGER HISTIGNORE FIGNORE PS1 EDITOR GIT_EDITOR PROMPT_COMMAND

# functions

function epochtime {
    \date --date @$1 --utc
}

# completion
COMPLETION_FILE=/fs/home/sewing/git/bash-completion/bash_completion
if [ -x $COMPLETION_FILE ] ; then
    . $COMPLETION_FILE
fi
