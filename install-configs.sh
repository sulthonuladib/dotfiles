#!/usr/bin/env bash

mkdir -p ~/.ssh && cp -R ./.ssh/* ~/.ssh/
rm -rf ~/.config/fish; cp -r ./XDG_CONFIG/fish/ ~/.config/
rm -rf ~/.config/ghostty/; cp -r ./XDG_CONFIG/ghostty/ ~/.config/
rm -rf ~/.config/git; cp -r ./XDG_CONFIG/git/ ~/.config/
rm -rf ~/.config/omarchy; cp -r ./XDG_CONFIG/omarchy/ ~/.config/
rm -rf ~/.config/tmux; cp -r ./XDG_CONFIG/tmux/ ~/.config/
