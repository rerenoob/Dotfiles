# Set default python alisa to be python 3
alias python='python3'
alias lsa='ls -la'
alias vi='nvim'

# Git shortcuts
# alias gbr='git checkout --track $(git branch -a | fzf)'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
# glf() { git log --all --grep="$1"; }
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gcm='git commit -m'

# System monitoring
alias sysinfo='top -o cpu -O +rsize -s 5 -n 20 -stats pid,command,cpu,mem,th,pstate,time'

# Speed test
alias speedtest='curl -o /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'


echo "Follow the rabbit"

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
export CLICOLOR=1

# set up environment variable
export FZF_DEFAULT_OPTS='--height=70% --preview="cat {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'
