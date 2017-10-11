#!/bin/bash

echo "Download plug.vim...."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Download wombat.vim...."
curl -fLo ~/.vim/colors/wombat.vim --create-dirs \
	https://raw.githubusercontent.com/sheerun/vim-wombat-scheme/master/colors/wombat.vim

echo "OK, now open your vim, and take :PlugInstall"
