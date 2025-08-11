def _command-exists [cmd: string] {
    which $cmd | is-not-empty
}

# Everyday commands
def --wrapped ll [...rest] {
    if (_command-exists eza) {
        eza -lahG --icons ...$rest
    } else if (_command-exists exa) {
        exa -lahFG ...$rest
    } else {
        ls -lah ...$rest
    }
}
alias lll = eza --tree --level=3 --long --icons --git
def mkfile [path: string] { mkdir (dirname $path); touch $path }
alias bat = bat --paging=never
# Refresh the timeout every time sudo is used (to avoid having to retype the password)
alias sudo-builtin = ^sudo
def --wrapped sudo [...args] { sudo-builtin -v; sudo-builtin ...$args }
def duc [] { du | sort-by physical -r }
alias cpr = rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 # From https://wiki.archlinux.org/title/rsync
alias mvr = rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files
alias nu-aliases = nu -c $"($env.EDITOR) ($env.HOME)/.config/nushell/autoload/aliases.nu"
alias notepad = nvim ~/work/notepad.md
alias df-builtin = df
def --wrapped df [...args] { df-builtin -h ...$args | | str replace "Mounted on" "Mountpoint" | detect columns | sort-by Size --reverse }
def --wrapped catimg [...args] {
    if (_command-exists viu) {
        viu ...$args
    }
    else if (_command-exists feh) {
        feh ...$args
    }
    else if (_command-exists display) {
        display ...$args
    }
    else if (_command-exists catimg) {
        catimg ...$args
    }
    else if (_command-exists tiv) {
        tiv ...$args
    }
}

# Mount home NAS
alias mount-home-public = sudo mount -t cifs //192.168.0.245/PublicNAS /mnt/nas_public -o $"uid=(id -u),gid=(id -g)"
def unmount-home-public [] {
    try { sudo umount /mnt/nas_public }
    ssh -t hoel@192.168.0.245 'sudo hdparm -y /dev/sda'
}
alias mount-home-private = sudo mount -t cifs //192.168.0.245/PrivateNAS /mnt/nas_private -o $"username=hoel,uid=(id -u),gid=(id -g)"
def unmount-home-private [] {
    try { sudo umount /mnt/nas_private }
    ssh -t hoel@192.168.0.245 'sudo hdparm -y /dev/sdb'
}

# Git
def gu [] {
    git add --update .
    git commit --amend --no-edit
    git push --force-with-lease
}
def fix-ssh-file-permissions [] {
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_ed25519
    chmod 600 ~/.ssh/id_ed25519.pub
    chmod 644 ~/.ssh/config
}

# Cargo
alias carc = cargo clippy -- -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used -W clippy::expect_used -A dead_code
alias carc-fix = cargo clippy --allow-dirty --fix -- -W clippy::pedantic -W clippy::nursery -W clippy::unwrap_used -W clippy::expect_used -A dead_code

# Python
alias tb = tensorboard --logdir . --samples_per_plugin 'scalars=500,images=500'
def rr [] { ruff check --fix; ruff format }
def rf [] { ruff check --fix --unsafe-fixes; ruff format }

# Maintenance
# Arch
def pacman-install [] { pacman -Sql | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S }
def pacman-remove [] { pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns }
def pacman-update-mirrors [] {
    sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    sudo reflector --verbose --protocol https --latest 200 --number 20 --sort rate --save /etc/pacman.d/mirrorlist
}
# Other
alias journal-errors = sudo journalctl -b -p err..alert

# Misc
def most-used-commands [] { history | get command | uniq -c | sort-by -r count | first 10 }
