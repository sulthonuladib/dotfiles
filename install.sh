#!/usr/bin/bash

# Config dir and files
NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_CONFIG_FILE="$NVIM_CONFIG_DIR/init.vim"
COC_CONFIG_FILE="$NVIM_CONFIG_DIR/coc-settings.json"
TMUX_CONFIG_FILE="$HOME/.tmux.conf"
GIT_CONFIG_FILE="$HOME/.gitconfig"
VIMPLUG_DESTINATION="$HOME/.local/share/nvim"

# Binary or program installation
NVIM_EXECUTABLE_FILES="$(which nvim)"
TMUX_EXECUTABLE_FILES="$(which tmux)"
GIT_EXECUTABLE_FILES="$(which git)"

echo "Installing neovim pre-release"
if [ -f $NVIM_EXECUTABLE_FILES ]; then
    echo "neovim already installed no need to install"
else
    echo "Installing neovim from source"
    git clone https://github.com/neovim/neovim;
    make && sudo make install;
fi

echo "Installing vim-plug";
echo "thanks to https://github.com/junegunn";
if [ -d $VIMPLUG_DESTINATION ]; then
    echo "vim-plug already installed";
else
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi


echo "Installing tmux";
if [ -f $TMUX_EXECUTABLE_FILES ]; then
    echo "tmux exist, skipping tmux";
else
    echo "Installing tmux";
    sudo pacman -S tmux;
fi

echo "Installing git";
if [ -f $GIT_EXECUTABLE_FILES ]; then
    echo "git exist, skipping git";
else
    echo "Installing tmux";
    sudo pacman -S git
fi

echo "Setting up https://github.com/sulthonuladib/dotfiles";

echo "Creating neovim config directory";
if [ -d $NVIM_CONFIG_DIR ]; then
    echo "Failed to create $NVIM_CONFIG_DIR folder exist";
else
    echo "$NVIM_CONFIG_DIR created";
    mkdir "/home/$(whoami)/.config/nvim"; fi

echo "Linking neovim config";
if [ -f $NVIM_CONFIG_FILE ]; then
    echo "Failed to link $NVIM_CONFIG_FILE file exist";
else
    echo "$NVIM_CONFIG_FILE successfully linked";
    ln -s "$(pwd)/init.vim" "/home/$(whoami)/.config/nvim/init.vim";
fi

echo "Linking neovim coc-settings plugin"
if [ -f $COC_CONFIG_FILE ]; then
    echo "Failed to link $COC_CONFIG_FILE file exist";
else
    echo "$COC_CONFIG_FILE successfully linked";
    ln -s "$(pwd)/coc-settings.json" "/home/$(whoami)/.config/nvim/coc-settings.json";
fi

echo "Linking tmux config file"
if [ -f $TMUX_CONFIG_FILE ]; then
    echo "Failed to link $TMUX_CONFIG_FILE file exist";
else
    echo "$TMUX_CONFIG_FILE successfully linked";
    ln -s "$(pwd)/tmux.conf" "/home/$(whoami)/.tmux.conf";
fi

echo "Linking gitconfig file"
if [ -f $GIT_CONFIG_FILE ]; then
    echo "Failed to link $GIT_CONFIG_FILE file exist";
else
    echo "$GIT_CONFIG_FILE successfully linked";
    ln -s "$(pwd)/gitconfig" "/home/$(whoami)/.gitconfig";
fi

