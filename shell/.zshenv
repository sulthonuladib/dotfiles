# the only true editor
export EDITOR="nvim"
# for scrolling less pager in tmux session
export LESS='-R --mouse --wheel-lines=5'

# RustBTW
. "$HOME/.cargo/env"

## Yes a lot of Yavascript
# fnm for Node
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# Bun Stuff
[ -s "/home/sulthonuladib/.bun/_bun" ] && source "/home/sulthonuladib/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Deno
# . "/home/sulthonuladib/.deno/env"


# Go Bin and Go Bin Bin (lol)
export PATH="$HOME/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

#zig
export PATH="$HOME/.local/share/zig:$PATH"

# local bin
export PATH="$HOME/bin:$PATH"

# scrcpy
# export PATH="$HOME/bin/scrcpy:$PATH"
