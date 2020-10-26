#!/bin/sh


ln -f bashrc $HOME/.bashrc
ln -f bash.functions $HOME/.bash.functions

ln -f zshrc $HOME/.zshrc

# vim/nvim
ln -f vimrc  $HOME/.vimrc
mkdir -p $HOME/.config/nvim
ln -f init.vim $HOME/.config/nvim/init.vim
ln -f coc-settings.json  $HOME/.config/nvim/
ln -f coc.vim  $HOME/.config/nvim/

ln -f tmux.conf $HOME/.tmux.conf
ln -f alacritty.yml $HOME/.alacritty.yml
ln -f chunkwmrc $HOME/.chunkwmrc
ln -f skhdrc $HOME/.skhdrc
ln -f yabairc $HOME/.yabairc
