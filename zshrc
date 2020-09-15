
# Path to oh-my-zsh installation.
export ZSH="/Users/stevenewing/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="terminalparty"

# Hyphen-insensitive completion.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# FZF
DISABLE_FZF_AUTO_COMPLETION=true

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    fzf
    bazel
    )

source $ZSH/oh-my-zsh.sh

#
## User Configuration
#

# read our functions
source ~/.bash.functions > /dev/null
RCFILE_BASE=~/git/dotfiles

# General Configuration
bindkey -e              # set emacs/readline-style editing
set -k                  # allow comments in interactive mode

# Aliases

# path utilities
alias realpath="perl -MCwd -e 'print Cwd::realpath(shift()).\"\\n\";'"

# numbers, bases
alias hex='printf "0x%08x\n"'
alias dec='printf "%d\n"'
alias bin="perl -e 'printf(\"%b\n\", shift());'"

# Spaces, text, etc.
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
# PS1="\h % "
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
# XXX: shopt -s histappend
HISTIGNORE=" *:ll:ll *:[bf]g:exit:history:history *:bc"
HISTTIMEFORMAT="%Y-%m-%d-%T "
HISTSIZE=5000
HISTDIR="$HOME/.history"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

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

# Remove esc-c, chagne to esc-q
# bind "$(bind -s | grep '^"\\ec"' | sed 's/ec/C-q/')"
# [[ $- =~ i ]] && bind '"\ec": nop'

# Fix crap binding for CTRL-T
bindkey '^t'  gosmacs-transpose-chars

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

# pyenv
eval "$(pyenv init -)"

# rbenv
eval "$(rbenv init -)"

# other rc files
compgen -G "$HOME/.zshrc.*" > /dev/null
rc=$?
if [ "$rc" -eq 0 ] ; then
    for rc in $HOME/.zshrc.* ; do
        source "$rc"
    done
fi
