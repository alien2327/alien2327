#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -sL install-node.vercel.app/lts | bash

curl -fLo ~/.vimrc \
    https://raw.githubusercontent.com/alien2327/alien2327/main/vimrc
