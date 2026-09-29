# Omarchy environment parity (mirrors /usr/share/omarchy/default/bash/env-bootstrap + envs)
set -gx OMARCHY_PATH /usr/share/omarchy
fish_add_path $HOME/.local/bin $HOME/.local/share/mise/shims $HOME/.opencode/bin

set -gx EDITOR "nvim"
set -gx SUDO_EDITOR $EDITOR
set -gx BROWSER omarchy-launch-browser
set -gx BAT_THEME ansi
set -gx MANROFFOPT "-c"
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Tool integrations (mirrors /usr/share/omarchy/default/bash/init)
if command -q mise
    mise activate fish | source
end

set -g fish_greeting


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME '/home/sulthonuladib/.local/share/pnpm'
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
