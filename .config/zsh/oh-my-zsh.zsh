# Because why use only zinit when you can have two plugins managers ?
# Standard plugins can be found in $ZSH/plugins/
# vi-mode does not work properly when installed through zinit.
plugins=(
    vi-mode
)
if [ -f $HOME/.oh-my-zsh/oh-my-zsh.sh ]; then
    export ZSH="${HOME}/.oh-my-zsh"
else
    export ZSH="${XDG_DATA_HOME}/.oh-my-zsh"
fi
source $ZSH/oh-my-zsh.sh
