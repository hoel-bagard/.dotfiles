# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

HISTSIZE=10000
SAVEHIST=10000
HIST_STAMPS="%y/%m/%d %T"
# HISTFILE=~/.cache/zsh/history

ZSH_THEME="robbyrussell"
export ZSH="/home/hoel/.oh-my-zsh"  # Path to your oh-my-zsh installation.
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom  # Would you like to use another custom folder than $ZSH/custom?

# Zsh options
setopt HIST_IGNORE_DUPS  # TODO: Check if that's not the default
setopt sharehistory   # It's the default, but just in case

# Spelling correction   ("correctall" corrects commands and all arguments, "correct" corrects only commands)
setopt correctall
# ENABLE_CORRECTION="true"

# Basic autocompletion   # TODO: See if usefull  (probably not)
# autoload -Uz compinit
# zstyle ':completion:*' menu select
# zstyle ':completion::complete:*' gain-privileges 1  # Enable auto-completion for commands starting with sudo
# zmodload zsh/complist
# compinit
# _comp_options+=(globdots)  # Include hidden files

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    ripgrep
    rsync
    archlinux
    colorize
    zsh-syntax-highlighting
    zsh-autosuggestions
    command-not-found
    docker
    # rust
    # bgnotify
    # colored-man-pages
    # virtualenv
    # autojump    # https://github.com/wting/autojump
)


# TODO
# # vi mode
# bindkey -v
# export KEYTIMEOUT=1
# # Change cursor shape for different vi modes.
# function zle-keymap-select {
#     if [[ ${KEYMAP} == vicmd ]] ||
#            [[ $1 = 'block' ]]; then
#         echo -ne '\e[1 q'
#     elif [[ ${KEYMAP} == main ]] ||
#              [[ ${KEYMAP} == viins ]] ||
#              [[ ${KEYMAP} = '' ]] ||
#              [[ $1 = 'beam' ]]; then
#         echo -ne '\e[5 q'
#     fi
# }

# Export environment variables
export $(envsubst < $HOME/.env)

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
source $ZSH/oh-my-zsh.sh

# Source powerlevel10k theme. First path is the one recommended in the install instructions.
# Second one is if installed through the AUR, third one is a dirty way that sometimes happens.
if [ -f ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme ]; then
    source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme
elif [ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]; then
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
else
    source ~/powerlevel10k/powerlevel10k.zsh-theme
fi

# Source hitachi dotfiles if on work PC.
if [ -f $HOME/hitachi-dotfiles/proxy-commands.zsh ]; then
    source $HOME/hitachi-dotfiles/proxy-commands.zsh
fi
if [ -f $HOME/hitachi-dotfiles/hitachi_aliases.zsh ]; then
    source $HOME/hitachi-dotfiles/hitachi_aliases.zsh
fi

# Japanese inputs
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# Set neovim as default text editor
export EDITOR=nvim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To sign commits with git(hub)
export GPG_TTY=$TTY

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# Below is used (among other things) if poetry is installed for the user only.
export PATH="$HOME/.local/bin:$PATH"

# Disable zsh auto-correct for the following words / regex.
CORRECT_IGNORE_FILE=".*"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
neofetch
