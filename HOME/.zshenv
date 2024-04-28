. "$HOME/.cargo/env"

# the best editor
export EDITOR=nvim

# the best thing ever
bindkey -s ^f "tmux-sessionizer\n"

# node yavascript stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# local bin
export PATH="$HOME/.local/bin:$PATH"
# go bin
export PATH="$HOME/go/bin:$PATH"
# snap bin
export PATH="/snap/bin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun
[ -s "/home/sulthonuladib/.bun/_bun" ] && source "/home/sulthonuladib/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
