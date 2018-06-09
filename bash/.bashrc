# Add Git branch prompt
#function parse_git_branch {
#	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
#}

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* (*\([^)]*\))*/\1/'
}

markup_git_branch() {
  if [[ -n $@ ]]; then
    if [[ -z $(git status --porcelain 2> /dev/null) ]]; then
      echo -e "\001\033[32m\002($@)\001\033[0m\002"
    else
      echo -e "\001\033[31m\002($@*)\001\033[0m\002"
    fi
  fi
}

export PS1="\u \[$(tput setaf 2)\][\W] \[$(tput setaf 1)\]\$(markup_git_branch \$(parse_git_branch))\[$(tput setaf 7)\]> \[$(tput sgr0)\]"

#export PS1="\h:\W\$(markup_git_branch \$(parse_git_branch)) \u$ "

# Custom bash prompt via kirsle.net/wizards/ps1.html
#export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

#export PS1="\u  \[$(tput setaf 2)\][\W] \[$(tput setaf 1)\]\$(parse_git_branch)\[$(tput setaf 7)\]> \[$(tput sgr0)\]"

#export PS1="\u  \[$(tput setaf 2)\][\W] \[$(tput setaf 1)\]\$(markup_git_branch \$(parse_git_branch))\[$(tput setaf 7)\]> \[$(tput sgr0)\]"

#export PS1="\n\[\033[38;5;1m\]\u\[$(tput sgr0)\]@\[\033[38;5;5m\]\h\[$(tput sgr0)\] \[\033[38;5;4m\]\w\[$(tput sgr0)\]\n> "
