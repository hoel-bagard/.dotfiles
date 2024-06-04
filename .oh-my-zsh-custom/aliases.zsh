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
alias zshrc="${=EDITOR} ~/.zshrc"
if command -v nvim >/dev/null 2>&1; then
    alias vim="nvim"
fi
alias notepad="nvim ~/work/notepad.md"

# Git
alias gk="git ck"
alias gc="git c"
alias gcm="git cm"
alias ga="git commit --amend"
alias gp="git push"
alias gl="git pull"
alias gu="git add --update . && git commit --amend --no-edit && git push --force-with-lease"
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
alias sv="source .venv/bin/activate"
alias rr="ruff check . --fix; ruff format ."
alias rf="ruff check . --fix --unsafe-fixes"
alias create-venv-sys="virtualenv --system-site-packages .venv; source .venv/bin/activate"
alias create-venv="virtualenv .venv; source .venv/bin/activate"

# Maintenance
# Arch
alias pacman-install="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacman-remove="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias pacman-update-mirrors="sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup && sudo reflector --verbose --protocol https --latest 200 --number 20 --sort rate --save /etc/pacman.d/mirrorlist"
# Other
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
most-used-commands() { history | awk '{print $4}' | sort | uniq -c | sort -nr | head -10; }
