# Do not put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Set the bash history length
HISTSIZE=10000
HISTFILESIZE=20000

# Shell behavior, see the documentation for more: https://www.gnu.org/software///bash/manual/bash.html
shopt -s histappend   # Append to the history file, don't overwrite it
shopt -s checkwinsize # Update window size after each command (update the values of LINES and COLUMNS if necessary). On by default.
shopt -s cdspell      # Autocorrect typos in path names when using cd.
shopt -s cmdhist      # Save multi-line commands as one command. On by default.
shopt -s dirspell     # Attempt spelling correction on directory names during word completion if the directory name initially supplied does not exist.
shopt -s globstar     # ** pattern for recursive matches

# Color prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
