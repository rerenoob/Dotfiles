/Users/duongpham/LiveOverflow/matrix $USER
echo "Follow the rabbit"

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

# set up environment variable
export VENV=~/Projects/python/pyramid_tutorial/env

# Set default python alisa to be python 3
alias python='python3'
alias lsa='ls -la'

# Git branch in prompt.

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

export PS1="\[\033[33m\]\d - \[\033[1;33m\]\t \[\033[93m\]@ \[\033[1;93m\]\w\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\n☀️  "
