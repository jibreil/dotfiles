export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export BROWSER="chrome"
export EDITOR="nvim"
export READER="zathura"
export TERMINAL="urxvt"
export ZSH=$HOME/.oh-my-zsh
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export FZF_DEFAULT_OPTS="-m --reverse --height 10%"

ZSH_THEME="jibreil"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  colored-man-pages
  zsh-interactive-cd
)

source $HOME/.pw
source $ZSH/oh-my-zsh.sh

alias dl='cd ~/downloads'
alias dots='cd ~/github/dotfiles'
alias uni='cd ~/uni/year2/sem1'

alias birch='~/github/birch/birch -u kingk22 -x '/msg NickServ IDENTIFY $IRCPASS' -c '#kisslinux''
alias irc='~/github/icyrc/irc -n kingk22 -s chat.freenode.net'

alias clock='tty-clock -scD -C 5'
alias e='fzf | xargs -r $EDITOR'
alias el='exal'
alias exa='exa --group-directories-first'
alias exal='exa -lFh --group-directories-first'
alias gif='giph -s -l -c 1,1,1,0.3 -b 5 -p -5 ~/recordings/recording-$(date +'%Y-%m-%dT%H:%M:%S').gif'
alias n='nvim'
alias nf='neofetch --colors 5 7 7 5 5 7 --underline off --ascii_colors 5 5 5 5 5 5 --w3m --source ~/pictures/lock.png'
alias q='exit'
alias r='ranger'
alias za='zathura'

alias add='git add -A'
alias commit='git commit'
alias pull='git pull'
alias push='git push'
alias pullall="find . -maxdepth 1 -type d -exec sh -c '(cd {} && git pull)' ';'"
sendit() {
    git add -A
    git commit -m "$1"
    git push
}

c() {
    if [ $# -eq 0 ] ; then
        clear
    elif [ -d "$1" ] ; then
        cd "$1"
    elif [ -f "$1" ] ; then
        cat "$1"
    fi
}

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
