# Add Git branch prompt
#function parse_git_branch {
#	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
#}

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* (*\([^)]*\))*/\1/'
}

markup_git_branch() {
  if [[ -n $@ ]]; then
    echo -ne " on git:$(tput setaf 6)$@"
    if [[ -z $(git status --porcelain 2> /dev/null) ]]; then
      echo -e "$(tput setaf 2) o"
    else
      echo -e "$(tput setaf 1) x"
    fi
  fi
}

# kumo [dotfiles] (master*)>
#export PS1="\u \[$(tput setaf 2)\][\W] \[$(tput setaf 1)\]\$(markup_git_branch \$(parse_git_branch))\[$(tput setaf 7)\]> \[$(tput sgr0)\]"

# SliceOfFriedGold:dotfiles(master*) kumo$
#export PS1="\h:\W\$(markup_git_branch \$(parse_git_branch)) \u$ "

# Custom bash prompt via kirsle.net/wizards/ps1.html
# [kumo@SliceOfFriedGold dotfiles]$
#export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# kumo  [dotfiles] master>
#export PS1="\u  \[$(tput setaf 2)\][\W] \[$(tput setaf 1)\]\$(parse_git_branch)\[$(tput setaf 7)\]> \[$(tput sgr0)\]"

# kumo  [dotfiles] (master*)>
#export PS1="\u  \[$(tput setaf 2)\][\W] \[$(tput setaf 1)\]\$(markup_git_branch \$(parse_git_branch))\[$(tput setaf 7)\]> \[$(tput sgr0)\]"

# kumo@SliceOfFriedGold ~/dotfiles
#export PS1="\n\[\033[38;5;1m\]\u\[$(tput sgr0)\]@\[\033[38;5;5m\]\h\[$(tput sgr0)\] \[\033[38;5;4m\]\w\[$(tput sgr0)\]\n> "

# Custom bash prompt via kirsle.net/wizards/ps1.html
# kumo @  in ~/dotfiles on git:master x [22:05:41]
export PS1="\[$(tput setaf 6)\]\u \[$(tput sgr0)\]@ \[$(tput bold)\]\[$(tput setaf 7)\] \[$(tput sgr0)\]in \[$(tput bold)\]\[$(tput setaf 3)\]\w\[$(tput sgr0)\]\$(markup_git_branch \$(parse_git_branch)) \[$(tput sgr0)\][\t]\[$(tput bold)\]\[$(tput setaf 1)\]\n\\$ \[$(tput sgr0)\]"
