#---------------------------------------------
# Command history configuration
#---------------------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

#---------------------------------------------
autoload -U compinit
compinit

#---------------------------------------------
autoload -U promptinit
promptinit
prompt fade green

#------------------------------
# Alias stuff
#------------------------------
alias spm="sudo pacman"
alias spmc="sudo pacman-color"
alias semegre="sudo emerge"
alias vimt='vim -c "NERDTree" $1'
alias gvimt='gvim -c "NERDTree" $1'
alias gvim='gvim -c "colorscheme neverland-darker" $1'
alias ssh-proxy='ssh -ND 4447 gonzih@devio.us'
alias git-rm-after='git ls-files --deleted | xargs git rm'
alias full-update='yaourt -Syu --aur --noconfirm'
alias full-update-src='ruby ~/scripts/arch_src_update.rb'
alias full-backup='/etc/backup/rbackup.sh'
alias full-restore='/etc/backup/rrestore.sh'
alias ff='MOZ_NO_REMOTE= firefox -p default &'
alias ff-dev='MOZ_NO_REMOTE= firefox -p development &'
alias pacman-remove-unused="sudo pacman-color -Rsn \$(pacman -Qqdt)"
alias install_oh_my_zsh="wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh"
alias g="git"
alias l="ls -lha --color=auto"

#------------------------------
# Variables
#------------------------------
export EDITOR="vim"
export PAGER="vimpager"
export PATH="${PATH}:${HOME}/bin"

#------------------------------
# Keybindings
#------------------------------
bindkey -v
typeset -g -A key
#bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[2~' overwrite-mode
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
bindkey '^R' history-incremental-search-backward
#vim style for dvorak
bindkey '^T' up-line-or-search
bindkey '^H' down-line-or-search
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for konsole
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
# for gnome-terminal
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# Emacs style
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

#------------------------------
# Local rc file
#------------------------------
if [ -f ~/.zsh/local ]; then
  . ~/.zsh/local
else
  touch ~/.zsh/local
fi

#------------------------------
# bundle aliases
#------------------------------
alias bi="bundle install --binstubs=.bin --path vendor/bundle"
alias be="bundle exec"
alias bl="bundle list"
alias bu="bundle update"
alias bp="bundle package"
alias bo="bundle outdated"

#------------------------------
# stop correctiong commands
#------------------------------
setopt nocorrectall

#------------------------------
# tmux aliases and functions
#------------------------------
alias tmux="tmux -2 -u"

tm() {
  [[ -z "$1" ]] && { echo "usage: tm <session>" >&2; return 1; }
  tmux has -t $1 && tmux attach -t $1 || tmux new -s $1
}

function __tmux-sessions() {
  local expl
  local -a sessions
  sessions=( ${${(f)"$(command tmux list-sessions)"}/:[ $'\t']##/:} )
  _describe -t sessions 'sessions' sessions "$@"
}
compdef __tmux-sessions tm

#------------------------------
# openssl encrypt and decrypt files
#------------------------------
enc() {
  [[ -z "$1" ]] && { echo "usage: enc <input> [output]" >&2; return 1; }
  [[ -n "$2" ]] && { out="$2"; } || { out="$1.enc"; }
  openssl enc -aes-256-ecb -salt -in "$1" -out $out
}

dec(){
  [[ -z "$1" ]] && { echo "usage: dec <input> [output]" >&2; return 1; }
  [[ -n "$2" ]] && { openssl enc -d -aes-256-ecb -in "$1" -out "$2" } || { openssl enc -d -aes-256-ecb -in "$1" }
}

#------------------------------
# check site availability
#------------------------------
down4me() {
  wget -qO - "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g' ;
}

#------------------------------
# vnc server start and stop
#------------------------------
alias vnc-start="vncserver -geometry 1440x900 -alwaysshared -dpi 96 :1"
alias vnc-stop="/usr/bin/vncserver -kill :1"

#------------------------------
# path and etc
#------------------------------
export PATH="./.bin:./script:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

# rvm

[[ $TERM = "screen" ]] && rvm use default

#------------------------------
# agnoster theme
#------------------------------

if [ -f $HOME/.zsh/git.zsh ]; then
  source $HOME/.zsh/git.zsh
fi

if [ -f $HOME/.zsh/agnoster.zsh-theme ]; then
  source $HOME/.zsh/agnoster.zsh-theme
fi

#------------------------------
# vim:set ts=2 sw=2 et:
#------------------------------

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
