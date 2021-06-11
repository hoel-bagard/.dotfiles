# Mount office
alias mount-sweet="sshfs xc-sweet:/home/hoel ~/mount/sweet -o dcache_timeout=3"
alias unmount-sweet="sudo umount ~/mount/sweet"
alias mount-cacao="sshfs xc-cacao:/home/hoel ~/mount/cacao -o dcache_timeout=3"
alias unmount-cacao="sudo umount ~/mount/cacao"
alias mount-bitter="sshfs bitter.xc:/home/hoel ~/mount/bitter -o dcache_timeout=3"
alias unmount-bitter="sudo umount ~/mount/bitter"
alias mount-black="sshfs black.xc:/home/hoel ~/mount/black -o dcache_timeout=3"
alias unmount-black="sudo umount ~/mount/black"
alias mount-dgx="sshfs dgx.xc:/home/hoel ~/mount/dgx -o dcache_timeout=3"
alias unmount-dgx="sudo umount ~/mount/dgx"
alias mount-nas-project="sudo mount -t cifs //192.168.2.129/projects/ ~/mount/project_NAS/ -o username=hoel,uid=$(id -u),gid=$(id -g)"
alias unmount-nas-project="sudo umount ~/mount/project_NAS"
alias mount-nas-rnd="sudo mount -t cifs //192.168.2.129/research/ ~/mount/research_NAS/ -o username=hoel,uid=$(id -u),gid=$(id -g)"
alias unmount-nas-rnd="sudo umount ~/mount/research_NAS/"
alias mount-nas-epson="sudo mount -t cifs //192.168.2.129/epson/ ~/mount/epson_NAS/ -o username=hoel,uid=$(id -u),gid=$(id -g)"
alias unmount-nas-epson="sudo umount ~/mount/epson_NAS/"

# Mount home
alias mount-office="sshfs hoel@113.43.242.146:/home/hoel/mount/ ~/mount/xc -oport=9923 -o dcache_timeout=3"
alias unmount-office="sudo umount ~/mount/xc"
alias ssh-office="ssh hoel@113.43.242.146 -p 9923 -t zsh"

# Refresh the timeout every time sudo is used (to avoid having to retype the password)
alias sudo='sudo -v; sudo '

alias ll="exa -lahFG"
alias ls='ls --color=auto'
alias arch-update="sudo pacman -Syu"
# alias duc="du -shcx /home/* | sort -hr"
alias duc="du -hd1 | sort -h"
alias journal-errors="sudo journalctl -b -p err..alert"
alias job-done="kdialog --passivepopup 'Job finished' --title 'Console'"
alias pip-update="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias git-config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
