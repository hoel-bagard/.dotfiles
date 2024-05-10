# Keep fastfetch before the Powerlevel10k instant prompt.
fastfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="robbyrussell"
export ZSH="/home/hoel/.oh-my-zsh"  # Path to your oh-my-zsh installation.
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom  # Would you like to use another custom folder than $ZSH/custom?

# Zsh history options. Those are the defaults in oh-my-zsh.
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt share_history          # share command history data
HISTSIZE=10000000
SAVEHIST=10000000
HIST_STAMPS="%y/%m/%d %T"

# Spelling correction   ("correctall" corrects commands and all arguments, "correct" corrects only commands)
setopt correctall

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    ripgrep
    rsync
    archlinux
    colorize
    fzf-tab
    zsh-syntax-highlighting
    zsh-autosuggestions
    command-not-found
    docker
    vi-mode
    colored-man-pages
)

# Export environment variables
export $(envsubst < $HOME/.env)

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
elif [ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]; then
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

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# fzf
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# Below is used (among other things) if poetry is installed for the user only.
export PATH="$HOME/.local/bin:$PATH"
# To be able to use binaries installed through cargo.
export PATH="$HOME/.cargo/bin:$PATH"

# Disable zsh auto-correct for the following words / regex.
CORRECT_IGNORE_FILE=".*"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
