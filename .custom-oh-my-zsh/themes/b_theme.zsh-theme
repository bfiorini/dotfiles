# -*- sh -*- vim:set ft=sh ai et sw=4 sts=4:
# Based on gnzh and risto
# https://github.com/bfiorini/dotfiles

# Check if we are on SSH or not
# To have this working with root, add this to visudo
# Defaults env_keep += "SSH_CLIENT SSH_CONNECTION SSH_TTY SSH_AUTH_SOCK"
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    eval host='%{$fg[yellow]%}%M' #SSH
else
    eval host='%{$fg[green]%}%M' # no SSH
fi
# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
    eval user='%{$fg[green]%}%n'
else # root
    eval user='%{$fg[red]%}%n'
fi

eval sep='%{$fg[cyan]%}@'
eval dir='%{$fg[blue]%}%2~'
PROMPT='${user}${sep}${host}:${dir} $(git_prompt_info)%{$reset_color%}%(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"
