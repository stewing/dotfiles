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
RCFILE_BASE=~/git/dotfiles

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
alias ts="gawk '{ print strftime(\"%Y-%m-%d %H:%M:%S\"), \$0; fflush(); }'"
alias rts="perl -wp $RCFILE_BASE/scripts/relative_timestamp.pl"

# weather
alias weather="curl -s wttr.in/Oakland"

# Misc stuff
alias agp='ag --pager "less -R"'
alias addrs="ip -o a | cut -d ' ' -f2,7"
alias jpp="python -mjson.tool"
alias allsrc='fd .*.\(go\|bazel\|py\|rb\|pl\|sh\)'
alias vim=nvim

# settings
EDITOR=nvim
GIT_EDITOR=$EDITOR
PS1="\h % "
PAGER="less"
FIGNORE=".o:~"
MAKEFLAGS="-j 4"
if [ -e /proc/cpuinfo ] ; then
    MAKEFLAGS="-j $(grep -c ^processor /proc/cpuinfo)"
fi
DIFF="nvim -d"

# Go
GOPATH=$HOME/go
export GOPATH

# history
shopt -s histappend
HISTIGNORE=" *:ll:ll *:[bf]g:exit:history:history *:bc"
HISTTIMEFORMAT="%Y-%m-%d-%T "
HISTSIZE=5000
HISTDIR="$HOME/.history"

# disable idiotic mac os shell warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# P4
alias openlist="p4 opened | sed 's/#.*//' | p4 -x - where | awk '/^\// {print \$3}'"
P4CONFIG=Perforce
P4EDITOR=nvim
P4DIFF="nvim -d"

export P4CONFIG P4EDITOR P4DIFF

# set up interactive vs. non-interactive stuff...
case $- in
    *i*)    # interactive shell
        case $OS in
            Linux)
                true
                ;;
            Darwin)
                PATH=$PATH:/usr/local/bin/:$HOME/.iterm2

                # homebrew stuff
                if [ ! -x /usr/local/bin/brew ] ; then
                    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
                fi

                if [ -x /usr/local/bin/brew ] ; then
                    PATH=$PATH:"$(brew --prefix)"/bin
                fi

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

        PROMPT_COMMAND="__write_history; __set_vars;"

        BASE16_SHELL=$HOME/.config/base16-shell/
        [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
        ;;
    *)      # non-interactive shell
        ;;
esac

PATH=$PATH:$GOPATH

export PAGER HISTSIZE HISTIGNORE HISTTIMEFORMAT FIGNORE PS1 EDITOR GIT_EDITOR PROMPT_COMMAND MAKEFLAGS

# completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

compgen -G "$HOME/.bashrc.*" > /dev/null
rc=$?
if [ "$rc" -eq 0 ] ; then
    for rc in $HOME/.bashrc.* ; do
        source "$rc"
    done
fi

# FZF and settings related to it
FZF_DEFAULT_COMMAND='fd --type f'
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND FZF_CTRL_T_COMMAND
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Remove esc-c, chagne to esc-q
bind "$(bind -s | grep '^"\\ec"' | sed 's/ec/C-q/')"
[[ $- =~ i ]] && bind '"\ec": nop'

# Fix crap binding for CTRL-T
bind '"\C-t": transpose-chars'

complete -F _fzf_path_completion -o default -o bashdefault ag vim nvim
complete -F _fzf_dir_completion -o default -o bashdefault tree

# rbenv
eval "$(rbenv init -)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# git setup
git config --global user.name "🚀 Steven Ewing 🌌"
git config --global diff.tool vimdiff3
git config --global diff.tool.vimdiff3.path nvim
git config --global merge.tool vimdiff3
git config --global merge.tool.vimdiff3.path nvim
# git config --global pull.rebase true

# pyenv
eval "$(pyenv init -)"
source "$HOME/.cargo/env"
