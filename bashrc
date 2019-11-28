source ~/Dotfiles/bash/alias
source ~/Dotfiles/bash/env

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# cd and lsa shortcut
cd() {
    builtin cd "$@"
    lsa
}
