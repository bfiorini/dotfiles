# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_CUSTOM=$HOME/.custom-oh-my-zsh
ZSH_THEME="b_theme"


ZSH_DISABLE_COMPFIX=true

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

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
plugins=(git debian systemd docker docker-compose kubectl)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR=/usr/bin/vim
[[ -f $HOME/.zsh_aliases ]] && source $HOME/.zsh_aliases

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

# To use ChefDK https://docs.chef.io/install_dk.html
#eval "$(chef shell-init zsh)"
autoload zmv

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR=$HOME/.sdkman
[[ -s $HOME/.sdkman/bin/sdkman-init.sh ]] && source $HOME/.sdkman/bin/sdkman-init.sh

# The next line updates PATH for the Google Cloud SDK.
[[ -s $HOME/google-cloud-sdk/path.zsh.inc ]] && source $HOME/google-cloud-sdk/path.zsh.inc

# The next line enables shell command completion for gcloud.
[[ -s $HOME/google-cloud-sdk/completion.zsh.inc ]] && source $HOME/google-cloud-sdk/completion.zsh.inc

# Add local bin dir
path+=$HOME/bin
# Flux
path+=/snap/fluxctl/current/bin
export FLUX_FORWARD_NAMESPACE=flux
# fix openssl path for python3 in docker-compose
export LD_LIBRARY_PATH="/usr/local/lib"

# kubectl autocomplete
[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

# fix gcloud python sdk
export CLOUDSDK_PYTHON="/usr/bin/python2"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
