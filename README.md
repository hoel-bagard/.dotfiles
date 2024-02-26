# My dotfiles

## Install
## Using pure git
This way of doing is taken from [this hacker news thread](https://news.ycombinator.com/item?id=11071754).

```zsh
export dotfiles_tmp_dir=$HOME/dotfiles-tmp
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:hoel-bagard/.dotfiles.git $dotfiles_tmp_dir

# Get the submodules.
mv -v ~/$dotfiles_tmp_dir/.gitmodules ~/
git submodule update --init --recursive

# Move all the files.
mv -v $dotfiles_tmp_dir/.* ~/
mv -v $dotfiles_tmp_dir/*.* ~/
mv -v $dotfiles_tmp_dir/README.md ~/
rmdir $dotfiles_tmp_dir

# Special case for nvchad's config
ln -s ~/.config/nvchad_custom ~/.config/nvim/lua/custom
```

TODO: fully move to stow (or the nix home manager thing?).\
This will mean that `~/.config/nvim/lua/custom` will no longer be tracked if using pure git, but that should be fine on the servers.\
(using stow, the file that is actually tracked is the one in the .dotfiles dir, not the simlink, so there's no submodule issue.)

## Using [stow](https://www.gnu.org/software/stow/)  (untested)
Using `stow` has the following advantages:
- It should make it easier to manage confirmation files in submodules (like `~/.config/nvim/lua/custom`).
- It removes the need for the `.gitignore`

However `stow` might not be present on server, and it requires using the `git-config` alias to manage the dotfiles from the home folder.

From the home folder, do:
```console
git clone git@github.com:hoel-bagard/.dotfiles.git .dotfiles

# Get the submodules.
ln -s .dotfiles/.gitmodules .gitmodules
git submodule update --init --recursive

cd .dotfiles
stow .

# Special case for nvchad's config.
ln -s ~/.config/nvchad_custom ~/.config/nvim/lua/custom
```

## Installing dependencies
### Arch
See [these instructions](https://github.com/hoel-bagard/arch-cheatsheet/blob/master/4-shell.md) to install the necessary packages on Arch Linux.

### Tmux
Press `prefix + I` (capital i, as in Install) while in tmux to fetch the plugins. `prefix` is set to `C-space`.
