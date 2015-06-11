#!/bin/bash

VIMHOME=`pwd`
BUNDLE_DIR="$VIMHOME/bundle"

dpkg -s git 2>&1 > /dev/null

if [ $? -ne 0 ]; then
	echo "Please install git first."
	exit 1
fi

if [ ! -d "$BUNDLE_DIR" ]; then
	echo "Create folder: $BUNDLE_DIR"
	mkdir $BUNDLE_DIR
fi

echo "Clone gmarik/Vundle.vim"

git clone https://github.com/gmarik/Vundle.vim.git $BUNDLE_DIR/Vundle.vim

echo "OK, now open your vim, and take :PluginInstall!"
