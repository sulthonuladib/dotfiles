#!/usr/bin/bash

NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_CONFIG_FILE="$NVIM_CONFIG_DIR/init.vim"
COC_CONFIG_FILE="$NVIM_CONFIG_DIR/coc-settings.json"
TMUX_CONFIG_FILE="$HOME/.tmux.conf"
GIT_CONFIG_FILE="$HOME/.gitconfig"

echo "Setting up https://github.com/sulthonuladib/dotfiles";
echo -e "--------------------------------\n";

echo "Creating neovim config directory";
if [ -d $NVIM_CONFIG_DIR ]; then
    echo "Failed to create $NVIM_CONFIG_DIR folder exist";
else
    echo "$NVIM_CONFIG_DIR created";
    mkdir "/home/$(whoami)/.config/nvim";
fi
echo -e "--------------------------------\n";

echo "Linking neovim config";
if [ -f $NVIM_CONFIG_FILE ]; then
    echo "Failed to link $NVIM_CONFIG_FILE file exist";
else
    echo "$NVIM_CONFIG_FILE successfully linked";
    ln -s "$(pwd)/init.vim /home/$(whoami)/.config/nvim/init.vim";
fi
echo -e "--------------------------------\n";

echo "Linking neovim coc-settings plugin"
if [ -f $COC_CONFIG_FILE ]; then
    echo "Failed to link $COC_CONFIG_FILE file exist";
else
    echo "$COC_CONFIG_FILE successfully linked";
    ln -s "$(pwd)/coc-settings.json /home/$(whoami)/.config/nvim/coc-settings.json";
fi
echo -e "--------------------------------\n";

echo "Linking tmux config file"
if [ -f $TMUX_CONFIG_FILE ]; then
    echo "Failed to link $TMUX_CONFIG_FILE file exist";
else
    echo "$TMUX_CONFIG_FILE successfully linked";
    ln -s "$(pwd)/tmux.conf /home/$(whoami)/.tmux.conf";
fi
echo -e "--------------------------------\n";

echo "Linking gitconfig file"
if [ -f $GIT_CONFIG_FILE ]; then
    echo "Failed to link $GIT_CONFIG_FILE file exist";
else
    echo "$GIT_CONFIG_FILE successfully linked";
    ln -s "$(pwd)/gitconfig /home/$(whoami)/.gitconfig";
fi
echo -e "--------------------------------\n";

