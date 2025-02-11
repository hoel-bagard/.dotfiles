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

# Spelling correction   ("correctall" corrects commands and all arguments, "correct" corrects only commands)
setopt correctall

# Export environment variables
export $(envsubst < $HOME/.env)

# Use nvim instead of colored-man-pages.
export MANPAGER='nvim +Man!'

# Japanese inputs
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# To sign commits with git(hub)
export GPG_TTY=$TTY

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
