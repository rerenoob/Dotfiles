source ~/Dotfiles/bash/alias
source ~/Dotfiles/bash/env

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# cd and ls shortcut
cd() {
    builtin cd "$@"
    ls -la
}
