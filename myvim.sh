#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -sL install-node.vercel.app/lts | bash

curl -fLo ~/.vimrc \
    https://raw.githubusercontent.com/alien2327/alien2327/main/vimrc

echo "Post setting"
echo "CocInstall coc-json coc-tsserver coc-pyright"
echo "LSP: https://github.com/neoclide/coc.nvim/wiki/Language-servers"
echo "coc-json coc-tsserver coc-cmake coc-clangd coc-pyright coc-sh coc-go coc-java coc-html coc-rls"
