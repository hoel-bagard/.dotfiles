# Keep fastfetch before the Powerlevel10k instant prompt.
fastfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zsh history options.
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HIST_STAMPS="%y/%m/%d %T"
HISTDUP=erase  # erase duplicates within history file.
setopt appendhistory  # append to history instead of overwriting it.
setopt share_history  # share command history data
setopt hist_ignore_space  # A command starting with a space will not be written to the history file.
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups  # ignore duplicated commands history list
setopt hist_find_no_dups

# Set the directory we want to store zinit and plugins.
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if not done yet.
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
zinit snippet OMZP::rsync
zinit snippet OMZP::colorize
zinit snippet OMZP::docker
# This works fine but is quite slow. Maybe try it again after completely removing oh-my-zsh.
# zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice as"completion"; zinit snippet OMZP::ripgrep/_ripgrep

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q  # zinit optimization option.

# Spelling correction   ("correctall" corrects commands and all arguments, "correct" corrects only commands)
setopt correctall

# Because why use only zinit when you can have two plugins managers ?
# Standard plugins can be found in $ZSH/plugins/
# vi-mode does not work properly when installed through zinit.
plugins=(
    vi-mode
    direnv
)
if [ -f $HOME/.oh-my-zsh/oh-my-zsh.sh ]; then
    export ZSH="${HOME}/.oh-my-zsh"
else
    export ZSH="${XDG_DATA_HOME}/.oh-my-zsh"
fi
source $ZSH/oh-my-zsh.sh

# Export environment variables
export $(envsubst < $HOME/.env)

# Use nvim instead of colored-man-pages.
export MANPAGER='nvim +Man!'

# Japanese inputs
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

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
# The two options below are to have a folder preview when doing cd.
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Below is used (among other things) if poetry is installed for the user only.
export PATH="$HOME/.local/bin:$PATH"
# To be able to use binaries installed through cargo.
export PATH="$HOME/.cargo/bin:$PATH"

# Disable zsh auto-correct for the following words / regex.
CORRECT_IGNORE_FILE=".*"

# Keybindings
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Source my own aliases
source $HOME/.oh-my-zsh-custom/aliases.zsh

# Source hitachi dotfiles if on work PC.
if [ -f $HOME/hitachi-dotfiles/proxy-commands.zsh ]; then
    source $HOME/hitachi-dotfiles/proxy-commands.zsh
fi
if [ -f $HOME/hitachi-dotfiles/hitachi_aliases.zsh ]; then
    source $HOME/hitachi-dotfiles/hitachi_aliases.zsh
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
