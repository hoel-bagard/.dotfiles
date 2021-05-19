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
HIST_STAMPS="dd/mm/yyyy"
# HISTFILE=~/.cache/zsh/history

ZSH_THEME="robbyrussell"
# Path to your oh-my-zsh installation.
export ZSH="/home/hoel/.oh-my-zsh"
# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

# Zsh options
setopt HIST_IGNORE_DUPS  # TODO: Check if that's not the default

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Basic autocompletion   # TODO: See if usefull  (probably not)
# autoload -Uz compinit
# zstyle ':completion:*' menu select
# zstyle ':completion::complete:*' gain-privileges 1  # Enable auto-completion for commands starting with sudo
# zmodload zsh/complist
# compinit
# _comp_options+=(globdots)  # Include hidden files


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    ripgrep
    rsync
    archlinux
    colorize
    zsh-syntax-highlighting
    zsh-autosuggestions
    command-not-found
    # bgnotify
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


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
neofetch
