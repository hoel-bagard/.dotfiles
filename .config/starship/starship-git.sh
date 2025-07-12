#!/usr/bin/env bash
# Color definitions
BLACK="0;0;0m"
GREEN="17;209;22m"  # #11d116
ORANGE="246;116;0m" # #f67400
BLUE="29;153;243m"  # #1d99f3

# ANSI color codes
FG_COLOR="\033[38;2;"
BG_COLOR="\033[48;2;"
RESET='\033[0m'     # Reset formatting
BG_RESET='\033[49m' # Reset only background color

# Git symbols
UNTRACKED_SYMBOL="?"
ADDED_SYMBOL="+"
MODIFIED_SYMBOL="!"
RENAMED_SYMBOL="»"
DELETED_SYMBOL="✘"
STASHED_SYMBOL="*"
UNMERGED_SYMBOL="="
AHEAD_SYMBOL="⇡"
BEHIND_SYMBOL="⇣"

git_status=""
STATUS=$(git status --porcelain -b 2>/dev/null || echo "")

# Check whether branch is ahead/behind
ahead_count=$(git rev-list --right-only --count origin...HEAD 2>/dev/null)
if [[ $ahead_count -ge 1 ]]; then
    git_status="${git_status} ${AHEAD_SYMBOL}${ahead_count}"
fi
behind_count=$(git rev-list --left-only --count origin...HEAD 2>/dev/null)
if [[ $behind_count -ge 1 ]]; then
    git_status="${git_status} ${BEHIND_SYMBOL}${behind_count}"
fi

# Check for stashes
if git rev-parse --verify refs/stash >/dev/null 2>&1; then
    stash_count=$(git stash list | wc -l)
    git_status="${git_status} ${STASHED_SYMBOL}${stash_count}"
fi

# Check for untracked files
if [[ "$STATUS" =~ $'\n'\?\?\ [[:print:]]+ ]]; then
    untracked_count=$(echo "$STATUS" | grep -c "^?? ")
    git_status="${git_status} ${UNTRACKED_SYMBOL}${untracked_count}"
fi

# Check for staged files
if echo "$STATUS" | grep -E '^[AMDU][ MD] ' &>/dev/null; then
    staged_count=$(echo "$STATUS" | grep -c -E '^[AMDU][ MD] ')
    git_status="${git_status} ${ADDED_SYMBOL}${staged_count}"
fi

# Check for modified files
modified_count=$(echo "$STATUS" | grep -c -E '^[ MARC]M ')
if [[ $modified_count -ge 1 ]]; then
    git_status="${git_status} ${MODIFIED_SYMBOL}${modified_count}"
fi

# Check for renamed files
if echo "$STATUS" | grep -E '^R[ MD] ' &>/dev/null; then
    renamed_count=$(echo "$STATUS" | grep -c -E '^R[ MD] ')
    git_status="${git_status} ${RENAMED_SYMBOL}${renamed_count}"
fi

# Check for deleted files
deleted_count=$(echo "$STATUS" | grep -c -E '^[MARCDU ]D |^D[ UM] ')
if [[ $deleted_count -ge 1 ]]; then
    git_status="${git_status} ${DELETED_SYMBOL}${deleted_count}"
fi

# Check for unmerged files
if echo "$STATUS" | grep -E '^(U[UDA] |AA |DD |[DA]U ) ' &>/dev/null; then
    unmerged_count=$(echo "$STATUS" | grep -c -E '^(U[UDA] |AA |DD |[DA]U ) ')
    git_status="${git_status} ${UNMERGED_SYMBOL}${unmerged_count}"
fi

branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo "unknown")

if [[ $modified_count -ge 1 || $deleted_count -ge 1 ]]; then
    output="${BG_COLOR}${ORANGE}${FG_COLOR}${BLUE}${FG_COLOR}${BLACK}   ${branch_name}${git_status}${FG_COLOR}${ORANGE}${BG_RESET}${RESET}"
else
    output="${BG_COLOR}${GREEN}${FG_COLOR}${BLUE}${FG_COLOR}${BLACK}   ${branch_name}${git_status}${FG_COLOR}${GREEN}${BG_RESET}${RESET}"
fi

echo -e "$output"
