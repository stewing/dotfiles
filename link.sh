#!/bin/sh


ln -f bashrc $HOME/.bashrc
ln -f bash.functions $HOME/.bash.functions

ln -f vimrc  $HOME/.vimrc
mkdir -p $HOME/.config/nvim
ln -f init.vim $HOME/.config/nvim/init.vim

ln -f vimrc.coc  $HOME/.vimrc.coc
ln -f tmux.conf $HOME/.tmux.conf
ln -f alacritty.yml $HOME/.alacritty.yml
ln -f chunkwmrc $HOME/.chunkwmrc
ln -f skhdrc $HOME/.skhdrc
ln -f yabairc $HOME/.yabairc
