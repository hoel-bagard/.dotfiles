# My dotfiles

## Install
## Using pure git
This way of doing is taken from [this hacker news thread](https://news.ycombinator.com/item?id=11071754).

```zsh
export dotfiles_tmp_dir=$HOME/dotfiles-tmp
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:hoel-bagard/.dotfiles.git $dotfiles_tmp_dir

# Move all the files.
mv -v $dotfiles_tmp_dir/.* ~/
mv -v $dotfiles_tmp_dir/*.* ~/
mv -v $dotfiles_tmp_dir/README.md ~/
rmdir $dotfiles_tmp_dir

# Get the submodules.
git submodule update --init --recursive

# Special case for nvchad's config since it is inside a submodule.
ln -s ~/.config/nvchad_custom ~/.config/nvim/lua/custom
```

## Using [stow](https://www.gnu.org/software/stow/)  (untested)

From the home folder, do:
```console
git clone git@github.com:hoel-bagard/.dotfiles.git .dotfiles

cd .dotfiles
stow .
cd

# Get the submodules.
git submodule update --init --recursive

# Special case for nvchad's config.
ln -s ~/.config/nvchad_custom ~/.config/nvim/lua/custom
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
