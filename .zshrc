# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gnzh"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git debian)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export EDITOR=/usr/bin/vim

# Alias
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias ll='ls --color=auto -lh'
alias la='ls --color=auto -la'
alias lla='ls --color=auto -lha'
alias lll='ls --color=auto -lh | less'

alias s='sudo su'
alias sadm='ssh aiadm'
alias a='cd /afs/cern.ch/user/b/bfiorini'
alias aw='cd /afs/cern.ch/user/b/bfiorini/workspace'
alias root='ssh -l root'

# Keys.
case $TERM in
        rxvt*|xterm*)
                bindkey "^[[7~" beginning-of-line #Home key
                bindkey "^[[8~" end-of-line #End key
                bindkey "^[[3~" delete-char #Del key
                bindkey "^[[A" history-beginning-search-backward #Up Arrow
                bindkey "^[[B" history-beginning-search-forward #Down Arrow
                bindkey "^[Oc" forward-word # control + right arrow
                bindkey "^[Od" backward-word # control + left arrow
                bindkey "^H" backward-kill-word # control + backspace
                bindkey "^[[3^" kill-word # control + delete
        ;;

        linux)
                bindkey "^[[1~" beginning-of-line #Home key
                bindkey "^[[4~" end-of-line #End key
                bindkey "^[[3~" delete-char #Del key
                bindkey "^[[A" history-beginning-search-backward
                bindkey "^[[B" history-beginning-search-forward
        ;;

        screen|screen-*)
                bindkey "^[[1~" beginning-of-line #Home key
                bindkey "^[[4~" end-of-line #End key
                bindkey "^[[3~" delete-char #Del key
                bindkey "^[[A" history-beginning-search-backward #Up Arrow
                bindkey "^[[B" history-beginning-search-forward #Down Arrow
                bindkey "^[Oc" forward-word # control + right arrow
                bindkey "^[Od" backward-word # control + left arrow
                bindkey "^H" backward-kill-word # control + backspace
                bindkey "^[[3^" kill-word # control + delete
        ;;
esac

bindkey "^R" history-incremental-pattern-search-backward 
bindkey "^S" history-incremental-pattern-search-forward
