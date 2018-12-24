#
# stewing@outlook.com bashrc
#

shopt -s checkwinsize
shopt -s execfail
shopt -s hostcomplete
shopt -s extglob

#
# read our functions
source ~/.bash.functions

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


# size
alias hr="perl -e 'my \$inp = shift; my (\$s, \$v); \$v = 1; \$inp=~s/,//g; if (\$inp >= 1073741824) {\$s = 'GB', \$v = 1073741824;} elsif (\$inp >= 1048576) { \$s = 'MB';\$v = 1048576 } elsif (\$inp >= 1024) { \$s = 'KB'; \$v = 1024} printf(\"%0.2f%s\\n\", \$inp/\$v, \$s);'"

# time
alias gmtime="perl -e '\print scalar(gmtime(shift())), \"\n\";'"
alias grep="grep --color"
alias timestamp="gawk '{ print strftime(\"%Y-%m-%d %H:%M:%S\"), \$0; fflush(); }'"

# weather
alias weather="curl -s wttr.in/Pittsburgh"

# Misc stuff
alias agp='ag --pager "less -R"'
alias addrs="ip -o a | cut -d ' ' -f2,7"
alias jpp="python -mjson.tool"

# settings
EDITOR=vim
GIT_EDITOR=$EDITOR
# PS1="\h % "
PS1="\\033[38;5;73m\h % \\033[0m"
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

# P4
alias openlist="p4 opened | sed 's/#.*//' | p4 -x - where | awk '/^\// {print \$3}'"
P4CONFIG=Perforce
P4EDITOR=vim
P4DIFF="vimdiff -R"

export P4CONFIG P4EDITOR P4DIFF

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

export PAGER HISTSIZE HISTIGNORE HISTTIMEFORMAT FIGNORE PS1 EDITOR GIT_EDITOR PROMPT_COMMAND MAKEFLAGS

# completion
COMPLETION_FILE=/fs/home/sewing/git/bash-completion/bash_completion
if [ -x $COMPLETION_FILE ] ; then
    . $COMPLETION_FILE
fi

compgen -G "$HOME/.bashrc.*" > /dev/null
rc=$?
if [ "$rc" -eq 0 ] ; then
    for rc in $HOME/.bashrc.* ; do
        source "$rc"
    done
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

