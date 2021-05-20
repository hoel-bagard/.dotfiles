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
