echo "Follow the rabbit"

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

# set up environment variable
export FZF_DEFAULT_OPTS='--height=70% --preview="cat {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

# Set default python alisa to be python 3
alias python='python3'
alias lsa='ls -la'

# Git shortcuts
alias gbr='git checkout --track $(git branch -a | fzf)'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
glf() { git log --all --grep="$1"; }

# Git branch in prompt.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

# Set the prompt
export PS1="\[\033[33m\]\d - \[\033[1;33m\]\t \[\033[93m\]@ \[\033[1;93m\]\w\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\n☀️  "

# Call .bashrc
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
