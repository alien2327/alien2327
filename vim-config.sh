#!/bin/bash

INSTALL_BASH_LSP=1
INSTALL_CLANG_LSP=1
INSTALL_CMAKE_LSP=1
INSTALL_DOCKER_LSP=1
INSTALL_FORTRAN_LSP=1
INSTALL_GOLANG_LSP=1
INSTALL_HTML_LSP=1
INSTALL_JAVA_LSP=1
INSTALL_JSON_LSP=1
INSTALL_TS_LSP=1
INSTALL_PY_LSP=1
INSTALL_RUST_LSP=1
INSTALL_SV_LSP=1
INSTALL_SQL_LSP=1

echo "export TERM=xterm-256color" >> ~/.bashrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -sL install-node.vercel.app/lts | bash

curl -fLo vim-config.py \
        https://raw.githubusercontent.com/alien2327/alien2327/main/vim-config.py

CocInstall="CocInstall "

if [[ $INSTALL_JSON_LSP -eq 1 ]]; then
    CocInstall=$CocInstall"coc-json "
fi

if [[ $INSTALL_HTML_LSP -eq 1 ]]; then
    CocInstall=$CocInstall"coc-html "
fi

if [[ $INSTALL_JAVA_LSP -eq 1 ]]; then
    CocInstall=$CocInstall"coc-java "
fi

if [[ $INSTALL_TS_LSP -eq 1 ]]; then
    CocInstall=$CocInstall"coc-tsserver "
fi

if [[ $INSTALL_BASH_LSP -eq 1 ]]; then
    CocInstall=$CocInstall"coc-sh "
fi

if [[ $INSTALL_CMAKE_LSP -eq 1 ]]; then
    CocInstall=$CocInstall"coc-cmake "
fi

if [[ $INSTALL_GOLANG_LSP -eq 1 ]]; then
    CocInstall=$CocInstall"coc-go "
fi

if [[ $INSTALL_PY_LSP -eq 1 ]]; then
    CocInstall=$CocInstall"coc-pyright "
fi

if [[ $INSTALL_DOCKER_LSP -eq 1 ]]; then
    npm install -g dockerfile-language-server-nodejs
fi

if [[ $INSTALL_CLANG_LSP -eq 1 ]]; then
    CocInstall=$CocInstall"coc-clangd "
    
    if [[ $EUID -eq 0 ]]; then
        apt-get install -y clangd
    else
        echo "To use clangd-lsp, run sudo apt install clangd"
    fi
fi

if [[ $INSTALL_SV_LSP -eq 1 ]]; then
    npm install -g @imc-trading/svlangserver
fi

if [[ $INSTALL_FORTRAN_LSP -eq 1 ]]; then
    pip install fortran-language-server
fi

curl -fLo ~/.vimrc \
        https://raw.githubusercontent.com/alien2327/alien2327/main/vimrc && \
sed -i 's/\r$//' ~/.vimrc && \
vim -es -c "PlugInstall" -c "qa!"

vim -es -c "$CocInstall" -c "qa!"
python3 vim-config.py \ 
        --config_fortran $INSTALL_FORTRAN_LSP \
        --config_dockerfile $INSTALL_DOCKER_LSP \
        --config_svlangserver $INSTALL_SV_LSP

source ~/.bashrc
