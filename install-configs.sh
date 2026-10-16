#!/usr/bin/env bash
set -euo pipefail

# Stow the dotfiles packages into $HOME.
#
# Each package mirrors its $HOME-relative path, because stow strips the package
# name and maps the package *contents* onto the target:
#   nvim/.config/nvim   -> ~/.config/nvim
#   shell/.zshrc        -> ~/.zshrc
#   bin/.local/bin/foo  -> ~/.local/bin/foo
#
# Usage:
#   ./install-configs.sh            # stow (install) the packages
#   ./install-configs.sh --restow   # restow (refresh links after moving files)
#   ./install-configs.sh --delete   # unstow (remove the links)
cd "$(dirname "$0")"

# tmux-old and wezterm are intentionally omitted; add them here to stow them.
packages=(nvim fish git ghostty omarchy tmux shell bin)

case "${1:-}" in
	"" | -S | --stow) action=() ;;
	-R | --restow) action=(-R) ;;
	-D | --delete) action=(-D) ;;
	*)
		echo "usage: $0 [--stow|--restow|--delete]" >&2
		exit 1
		;;
esac

stow "${action[@]}" --target="$HOME" "${packages[@]}"
