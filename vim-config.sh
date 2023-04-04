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

if [[ $EUID -eq 0 ]]; then
        apt-get update && apt-get install -y vim neovim
else
        git clone https://github.com/vim/vim.git
        cd vim && \
        ./configure --prefix=$HOME/.local && \
        make install
fi

echo "export TERM=xterm-256color" >> $HOME/.bashrc
echo "export PATH=$HOME/.local/bin:$PATH" >> $HOME/.bashrc
echo "export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH" >> $HOME/.bashrc

source $HOME/.bashrc

curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p $HOME/.local
curl -sL install-node.vercel.app/lts | bash -s -- -y

curl -fLo $HOME/.config/nvim/init.vim \
        https://raw.githubusercontent.com/alien2327/alien2327/main/vimrc
sed -i 's/\r$//' $HOME/.config/nvim/init.vim

source $HOME/.bashrc

vim -c "PlugInstall" -c "q" -c "qa!"

echo "set background=dark" >> $HOME/.vimrc
echo "colorscheme gruvbox" >> $HOME/.vimrc

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
    pip3 install fortran-language-server --quiet
fi

echo "Installing coc-lsp server with:"
echo "vim -c $CocInstall -c \"q\" -c \"qa!\""
vim -c $CocInstall -c "q" -c "qa!"

curl -fLo $HOME/.vim/vim-config.py \
    https://raw.githubusercontent.com/alien2327/alien2327/main/vim-config.py
python3 $HOME/.vim/vim-config.py \
    --config_fortran=$INSTALL_FORTRAN_LSP \
    --config_dockerfile=$INSTALL_DOCKER_LSP \
    --config_svlangserver=$INSTALL_SV_LSP
pip install jupyter --quiet

source $HOME/.bashrc
