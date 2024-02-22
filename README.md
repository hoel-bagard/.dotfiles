# .dotfiles

See full instructions at the end of https://gist.github.com/hoel-bagard/37f1aa8d38bb780c1c72bc3e390ec211  
Clone with:   (untested)
```
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:hoel-bagard/.dotfiles.git $HOME/myconf-tmp
mv -v ~/myconf-tmp/.* ~/
rmdir myconf-tmp
git-config submodule update --init --recursive
```

https://wiki.archlinux.org/title/Dotfiles#User_repositories \
https://news.ycombinator.com/item?id=11071754

## Dependency install
### Arch
See [arch install](https://github.com/hoel-bagard/arch-cheatsheet/blob/master/4-shell.md).

```console
sudo pacman -S zsh neofetch
yay -S --noconfirm zsh-theme-powerlevel10k-git
```

### User install
If packages cannot be install globally, do:
```console
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
~/powerlevel10k/gitstatus/install
```
