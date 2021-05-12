#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Color prompt
#PS1='[\u@\h \W]\$ '
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

source ~/.profile

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


# Custom mount
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

alias ll="exa -lahFG"
alias ls='ls --color=auto'
alias arch-update="sudo pacman -Syu"
# alias duc="du -shcx /home/* | sort -hr"
alias duc="du -hd1 | sort -h"
alias journal-errors="sudo journalctl -b -p err..alert"
alias job-done="kdialog --passivepopup 'Job finished' --title 'Console'"
alias pip-update="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias git-config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"


# For Dali / Cuda
export LD_LIBRARY_PATH="/opt/cuda/lib64:/opt/cuda/extras/CUPTI/lib64:/usr/lib/python3.8/site-packages/nvidia/dali"

