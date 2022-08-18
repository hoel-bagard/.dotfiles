# Mount office
alias mount-bitter="sshfs bitter.xc:/home/hoel ~/mount/bitter -o dcache_timeout=3"
alias unmount-bitter="sudo umount ~/mount/bitter"
alias mount-black="sshfs black.xc:/home/hoel ~/mount/black -o dcache_timeout=3"
alias unmount-black="sudo umount ~/mount/black"
alias mount-3090="sshfs 3090.xc:/home/hoel ~/mount/3090 -o dcache_timeout=3"
alias unmount-3090="sudo umount ~/mount/3090"
alias mount-dgx="sshfs dgx.xc:/home/hoel ~/mount/dgx -o dcache_timeout=3"
alias unmount-dgx="sudo umount ~/mount/dgx"
alias mount-censei="sshfs censei.xc:/home/hoel ~/mount/censei -o dcache_timeout=3"
alias unmount-censei="sudo umount ~/mount/censei"
alias mount-nas-project="sudo mount -t cifs //192.168.100.95/pub/ ~/mount/project_NAS/ -o username=guest01,uid=$(id -u),gid=$(id -g),password=Ilovecurry1"
alias unmount-nas-project="sudo umount ~/mount/project_NAS"
alias mount-nas2-project="sudo mount -t cifs //192.168.100.150/xc_backup/ ~/mount/project_NAS2/ -o username=guest01,uid=$(id -u),gid=$(id -g),password=Ilovecurry1"
alias unmount-nas2-project="sudo umount ~/mount/project_NAS2"

# Mount home NAS
alias mount-home-public="sudo mount -t cifs //192.168.0.245/PublicNAS /mnt/nas_public -o uid=$(id -u),gid=$(id -g)"
alias unmount-home-public="sudo umount /mnt/nas_public"
alias mount-home-private="sudo mount -t cifs //192.168.0.245/PrivateNAS /mnt/nas_private -o username=hoel,uid=$(id -u),gid=$(id -g)"
alias unmount-home-private="sudo umount /mnt/nas_private"

# Everyday commands
alias ll="exa -lahFG"
alias ls='ls --color=auto'
alias mkdir="mkdir -p"  # Create missing folders if needed
alias .1="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
# alias cat="bat"
alias sudo='sudo -v; sudo '  # Refresh the timeout every time sudo is used (to avoid having to retype the password)
alias duc="du -hcxd1 | sort -hr"  # du -shcx /home/* | sort -hr
# alias cpr="rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress"  # See https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/cp for details
alias cpr="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1"  # From https://wiki.archlinux.org/title/rsync
alias mvr="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "
alias tb="tensorboard --logdir . --samples_per_plugin 'scalars=500,images=500'"
alias sv="source venv/bin/activate"

# Maintenance
alias arch-update="sudo pacman -Syu"
alias pip-update="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias journal-errors="sudo journalctl -b -p err..alert"

# Dotfiles management
alias git-config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Misc
# alias job-done="kdialog --passivepopup 'Job finished' --title 'Console'"
