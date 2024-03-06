# Mount home NAS
alias mount-home-public="sudo mount -t cifs //192.168.0.245/PublicNAS /mnt/nas_public -o uid=$(id -u),gid=$(id -g)"
alias unmount-home-public="sudo umount /mnt/nas_public; ssh -t hoel@192.168.0.245 'sudo hdparm -y /dev/sda'"
alias mount-home-private="sudo mount -t cifs //192.168.0.245/PrivateNAS /mnt/nas_private -o username=hoel,uid=$(id -u),gid=$(id -g)"
alias unmount-home-private="sudo umount /mnt/nas_private; ssh -t hoel@192.168.0.245 'sudo hdparm -y /dev/sdb'"

# Everyday commands
if command -v eza >/dev/null 2>&1; then # Note: (( $+commands[exa] )) is zsh specific and not supported by shfmt
    alias ll="eza -lahG"
elif command -v exa >/dev/null 2>&1; then
    alias ll="exa -lahFG"
else
    alias ll="ls -lah"
fi
alias ls='ls --color=auto'
alias mkdir="mkdir -p"
mkfile() { mkdir -p "$(dirname "$1")" && touch "$1"; }
alias .1="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias bat="bat --paging=never"
alias sudo='sudo -v; sudo '      # Refresh the timeout every time sudo is used (to avoid having to retype the password)
alias duc="du -hcxd1 | sort -hr" # du -shcx /home/* | sort -hr
# alias cpr="rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress"  # See https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/cp for details
alias cpr="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1" # From https://wiki.archlinux.org/title/rsync
alias mvr="rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "
alias hx="helix"

# Git
alias gc="git c"
alias gcm="git cm"
alias gp="git p"
alias gu="git add . && git commit --amend --no-edit && git push --force-with-lease"
alias fix-ssh="chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_ed25519 && chmod 600 ~/.ssh/id_ed25519.pub && chmod 644 ~/.ssh/config"

# Cargo
alias card="cargo doc"
alias cardo="cargo doc --open"
alias carb="cargo build"
alias carc="cargo clippy -- -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used -W clippy::expect_used -A dead_code"
alias carc-fix="cargo clippy --allow-dirty --fix -- -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used -W clippy::expect_used -A dead_code"
alias cart="cargo test"

# Python
alias psh="poetry shell"
alias tb="tensorboard --logdir . --samples_per_plugin 'scalars=500,images=500'"
alias sv="source venv/bin/activate"
alias rr="ruff check . --fix && ruff format ."
alias create-venv-sys="virtualenv --system-site-packages venv; source venv/bin/activate"
alias create-venv="virtualenv venv; source venv/bin/activate"

# Maintenance
alias arch-update="sudo pacman -Syu"
alias pip-update="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias journal-errors="sudo journalctl -b -p err..alert"
alias disable-boost="sudo sh -c \"echo 0 >> /sys/devices/system/cpu/cpufreq/boost\""
alias enable-boost="sudo sh -c \"echo 1 >> /sys/devices/system/cpu/cpufreq/boost\""

# Dotfiles management
alias git-config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Work
alias xc-start="count-hours log start ~/work/xc/.count-hours.csv"
alias xc-end="count-hours log end ~/work/xc/.count-hours.csv"
alias xc-source="source $HOME/work/xc/xc-aliases/xc-aliases.zsh"

# Misc
# alias job-done="kdialog --passivepopup 'Job finished' --title 'Console'"
