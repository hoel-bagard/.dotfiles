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
# zinit ice as"completion"; zinit snippet OMZP::ripgrep/_ripgrep

zinit cdreplay -q  # zinit optimization option.
