# the only true editor
export EDITOR="nvim"
# for scrolling less pager in tmux session
export LESS='-R --mouse --wheel-lines=5'

# RustBTW
. "$HOME/.cargo/env"

## Yes a lot of Yavascript
# NVM for Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Bun Stuff
[ -s "/home/sulthonuladib/.bun/_bun" ] && source "/home/sulthonuladib/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# Deno
. "/home/sulthonuladib/.deno/env"


# Go Bin and Go Bin Bin (lol)
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# local bin
export PATH="$HOME/bin:$PATH"

# scrcpy
# export PATH="$HOME/bin/scrcpy:$PATH"
