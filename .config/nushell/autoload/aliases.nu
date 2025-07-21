def command-exists [cmd: string] {
    which $cmd | is-not-empty
}

# Mount home NAS
alias mount-home-public = sudo mount -t cifs //192.168.0.245/PublicNAS /mnt/nas_public -o $"uid=(id -u),gid=(id -g)"
def unmount-home-public [] {
    sudo umount /mnt/nas_public
    ssh -t hoel@192.168.0.245 'sudo hdparm -y /dev/sda'
}
alias mount-home-private = sudo mount -t cifs //192.168.0.245/PrivateNAS /mnt/nas_private -o $"username=hoel,uid=(id -u),gid=(id -g)"
def unmount-home-private [] {
    sudo umount /mnt/nas_private
    ssh -t hoel@192.168.0.245 'sudo hdparm -y /dev/sdb'
}

def --wrapped ll [...rest] {
    if (command-exists eza) {
        eza -lahG --icons ...$rest
    } else if (command-exists exa) {
        exa -lahFG ...$rest
    } else {
        ls -lah ...$rest
    }
}


# Create a file, also create the parent folders if necessary.
def mkfile [path: string] {
    mkdir (dirname $path)
    touch $path
}

alias bat = bat --paging=never
