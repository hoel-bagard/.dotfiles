# Mount office
alias mount-bitter="sshfs bitter.xc:/home/hoel ~/mount/bitter -o dcache_timeout=3"
alias unmount-bitter="sudo umount ~/mount/bitter"
alias mount-black="sshfs black.xc:/home/hoel ~/mount/black -o dcache_timeout=3"
alias unmount-black="sudo umount ~/mount/black"
alias mount-dgx="sshfs dgx.xc:/home/hoel ~/mount/dgx -o dcache_timeout=3"
alias unmount-dgx="sudo umount ~/mount/dgx"
alias mount-censei="sshfs censei.xc:/home/hoel ~/mount/censei -o dcache_timeout=3"
alias unmount-censei="sudo umount ~/mount/censei"
alias mount-nas-project="sudo mount -t cifs //192.168.100.95/pub/ ~/mount/project_NAS/ -o username=guest01,uid=$(id -u),gid=$(id -g),password=Ilovecurry1"
alias unmount-nas-project="sudo umount ~/mount/project_NAS"

# Everyday commands
alias ll="exa -lahFG"
alias ls='ls --color=auto'
alias sudo='sudo -v; sudo '  # Refresh the timeout every time sudo is used (to avoid having to retype the password)
alias duc="du -hcxd1 | sort -hr"
# alias cpr="rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress"  # See https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/cp for details
alias cpr="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1"  # From https://wiki.archlinux.org/title/rsync
alias mvr="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "

# Maintenance
alias arch-update="sudo pacman -Syu"
alias pip-update="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias journal-errors="sudo journalctl -b -p err..alert"

# Dotfiles management
alias git-config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Misc
# alias job-done="kdialog --passivepopup 'Job finished' --title 'Console'"
