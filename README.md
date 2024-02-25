# Hoel Bagard's dotfiles

## Git clone

```console
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:hoel-bagard/.dotfiles.git $HOME/dotfiles-tmp --recurse-submodules
mv -v ~/dotfiles-tmp/.* ~/
mv -v ~/dotfiles-tmp/*.* ~/
mv -v ~/dotfiles-tmp/README.md ~/
rmdir dotfiles-tmp
```

Install plugins (this should not be necessary, check)

```console
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
source ~/.zshrc
```

This way of doing is taken from [this hacker news thread](https://news.ycombinator.com/item?id=11071754).

Note:\
Another way to handle dotfiles would be to use [stow](https://www.gnu.org/software/stow/), but this involves trade offs (afaik).
Advantages:
- This would remove the need for the `.gitignore`
Disadvantages:
- Requires stow, which might not be present on servers.
- Symlinks are (imo) less intuitive.
- Managing dotfiles would require moving to the dotfiles folder or using the `git-config` alias.

## Installing dependencies
### Arch
See [these instructions](https://github.com/hoel-bagard/arch-cheatsheet/blob/master/4-shell.md) to install the necessary packages on Arch Linux.

### Tmux
Press `prefix + I` (capital i, as in Install) while in tmux to fetch the plugins. `prefix` is set to `C-space`.
