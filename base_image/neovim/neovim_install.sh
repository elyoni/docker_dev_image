#!/bin/bash

#set -v
#AUTOCOMPLE="coc"  # jedi, coc
#INIT_VIM_PATH=$HOME/.config/nvim/init.vim
INIT_VIM_PATH=init.vim
NEOVIM_PATH="$HOME/.config/nvim"
export N_PREFIX=$HOME/.n
#INIT_VIM_PATH=init.vim

function install_neovim
{

    echo ======= Install Neovim =======
    # Copy init file
    mkdir -p $NEOVIM_PATH
    cp -r $TMP_SCRIPTS/neovim/nvim/* $NEOVIM_PATH
    # Installation
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt-get update
    sudo apt-get install neovim -y
}


function install_requirements
{
    # Install python3 support
    sudo apt-get install python3-pip -y
    pip3 install pynvim
    pip3 install pylint --upgrade
    pip3 install neovim

    install_ripgrap
}

function install_ripgrap
{
    VERSION="12.1.1"
    DOWNLOAD_PATH=$HOME/Downloads/apps/ripgrep
    mkdir -p ${DOWNLOAD_PATH}
    wget -P ${DOWNLOAD_PATH} https://github.com/BurntSushi/ripgrep/releases/download/$VERSION/ripgrep_${VERSION}_amd64.deb
    sudo apt install ${DOWNLOAD_PATH}/ripgrep_${VERSION}_amd64.deb
}

function install_autocomplete
{
    #function install_coc
    #{
        #PATH="$PATH:$N_PREFIX"
        #pip3 install --user jedi --upgrade

        #sudo apt-get install npm -y
        #sudo npm install -g neovim
        #git clone https://github.com/tj/n $N_PREFIX
        #n 11

        #if ! cat $INIT_VIM_PATH | grep -iq "davidhalter/jedi-vim"; then
            #sed -i '/^" AutoCompletePlugin.*/a Plug '\''neoclide/coc.nvim'\'', { '\''branch'\'': '\''release'\'' }' $INIT_VIM_PATH
        #fi

        #nvim +PlugClean! +PlugInstall +UpdateRemotePlugins +qall

        #nvim +CocInstall coc-json coc-tsserver coc-python +qall
    #}

    #function install_jedi
    #{
        #if ! cat $INIT_VIM_PATH | grep -iq "davidhalter/jedi-vim"; then
            #sed -i '/^" AutoCompletePlugin.*/a Plug '\''davidhalter/jedi-vim'\''' $INIT_VIM_PATH
        #fi
        #if ! cat $INIT_VIM_PATH | grep -iq "Shougo/deoplete.nvim"; then
            #sed -i '/^" AutoCompletePlugin.*/a Plug '\''Shougo/deoplete.nvim'\'', { '\''do'\'': '\'':UpdateRemotePlugins'\'' }' $INIT_VIM_PATH
        #fi
        #if ! cat $INIT_VIM_PATH | grep -iq "zchee/deoplete-jedi"; then
            #sed -i '/^" AutoCompletePlugin.*/a Plug '\''zchee/deoplete-jedi'\''' $INIT_VIM_PATH
        #fi

        #if ! cat $INIT_VIM_PATH | grep -iq "g:deoplete#enable_at_startup = 1"; then
            #sed -i '/^" AutoCompleteSettings.*/a let g:deoplete#enable_at_startup = 1' $INIT_VIM_PATH
        #fi

        #pip3 install --user jedi --upgrade
        #pip3 install msgpack
    #}

    #if [ "$AUTOCOMPLE" = "coc" ]; then
        #install_coc

    #elif [ "$AUTOCOMPLE" = "jedi" ]; then
        #install_jedi
    #fi
    
    :
}

function install_plug_plugin_legacy
{
    local autoload_dir="$NEOVIM_PATH/autoload"
    echo ======= Install Neovim Plugins =======
    ### nvim plugins
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    nvim +PlugInstall +PlugClean! +qall
    echo ======= End  =======
}

function install_plug_plugin_new
{
    # I am replacing the plugin manager because I want it to be writen in lua
    git clone https://github.com/savq/paq-nvim.git \
        "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/opt/paq-nvim
}

function install
{
    install_neovim
    install_requirements
    install_plug_plugin_legacy 
}
"$@"
