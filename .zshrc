# Keep fastfetch before the Powerlevel10k instant prompt.
fastfetch

# Powerlevel10k, keep it here.
source $HOME/.config/zsh/p10k.zsh

# Set environment variables/settings.
source $HOME/.config/zsh/env.zsh

# Load completions.
autoload -Uz compinit && compinit

# Install plugins using zinit.
source $HOME/.config/zsh/zinit.zsh

# Source oh-my-zsh and load the oh-my-zsh plugins.
source $HOME/.config/zsh/oh-my-zsh.zsh

# Set-up various tools.
source $HOME/.config/zsh/tools/pyenv.zsh
source $HOME/.config/zsh/tools/zoxide.zsh
source $HOME/.config/zsh/tools/fzf.zsh  # Keep fzf after zoxide.

# Source my own aliases.
source $HOME/.config/zsh/aliases.zsh

# Source hitachi dotfiles if on work PC.
if [ -f $HOME/hitachi-dotfiles/hitachi_aliases.zsh ]; then
    source $HOME/hitachi-dotfiles/hitachi_aliases.zsh
fi
if [ -f $HOME/hitachi-dotfiles/proxy-commands.zsh ]; then
    source $HOME/hitachi-dotfiles/proxy-commands.zsh
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
