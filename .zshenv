# define pager dependant on what is available (less or more)
if (( ${+commands[bat]} )); then
    export PAGER='bat'
    # Uncomment below to use less as a pager
    export LESS='-FRSX'
    export BAT_PAGER="less -iRx4"
    # Uncomment below to disable pager
    # export LESS=''
    # export BAT_PAGER=""
elif (( ${+commands[less]} )); then
    export PAGER='less'
    export LESS='-iRx4'
elif (( ${+commands[more]} )); then
    export PAGER='more'
fi
