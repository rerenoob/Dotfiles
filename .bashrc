[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# cd and lsa shortcut
cd() {
    builtin cd "$@"
    lsa
}
