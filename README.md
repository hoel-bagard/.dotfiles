# My dotfiles

## Install

This way of doing is taken from [this hacker news thread](https://news.ycombinator.com/item?id=11071754).

```zsh
export dotfiles_tmp_dir=$HOME/dotfiles-tmp
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:hoel-bagard/.dotfiles.git $dotfiles_tmp_dir

# Move all the files.
mv -v $dotfiles_tmp_dir/.* ~/
mv -v $dotfiles_tmp_dir/*.* ~/
mv -v $dotfiles_tmp_dir/README.md ~/
rmdir $dotfiles_tmp_dir

# Optional, do not show untracked files (notably those in the .config folder)
git config --local status.showUntrackedFiles no
```

## Installing dependencies

### Arch

See [these instructions](https://github.com/hoel-bagard/arch-cheatsheet/blob/master/4-shell.md) to install the necessary packages on Arch Linux.

### Tmux

Install tpm:

```console
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then press `prefix + I` (capital i, as in Install) while in tmux to fetch the plugins. `prefix` is set to `C-space`.
