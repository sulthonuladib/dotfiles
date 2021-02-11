#!/usr/bin/env bash

mkdir /home/$(whoami)/.config/nvim;
ln -s $(pwd)/init.vim /home/$(whoami)/.config/nvim/init.vim;
