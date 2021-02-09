#!/bin/bash

#set -v
AUTOCOMPLE="jedi"  # jedi, coc
#INIT_VIM_PATH=$HOME/.config/nvim/init.vim
INIT_VIM_PATH=init.vim

function install_neovim
{

    echo ======= Install Neovim =======
    # Copy init file
    mkdir -p $HOME/.config/nvim
    cp $TMP_SCRIPTS/neovim/init.vim $INIT_VIM_PATH
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
}

function install_autocomplete
{
    function install_coc
    {
        pip3 install --user jedi --upgrade

        sudo apt-get install npm -y
        sudo npm chach clean -f
        sudo npm install -g n
        sudo npm install -g neovim
        sudo n stable

        # Install nodejs >= 10.12
        curl -sL install-node.now.sh/lts | bash
        nvim "+CocInstall coc-python"
    }

    function install_jedi
    {
        if ! cat $INIT_VIM_PATH | grep -iq "davidhalter/jedi-vim"; then
            sed -i '/^" AutoCompletePlugin.*/a Plug '\''davidhalter/jedi-vim'\''' $INIT_VIM_PATH
        fi
        if ! cat $INIT_VIM_PATH | grep -iq "Shougo/deoplete.nvim"; then
            sed -i '/^" AutoCompletePlugin.*/a Plug '\''Shougo/deoplete.nvim'\'', { '\''do'\'': '\'':UpdateRemotePlugins'\'' }' $INIT_VIM_PATH
        fi
        if ! cat $INIT_VIM_PATH | grep -iq "zchee/deoplete-jedi"; then
            sed -i '/^" AutoCompletePlugin.*/a Plug '\''zchee/deoplete-jedi'\''' $INIT_VIM_PATH
        fi

        if ! cat $INIT_VIM_PATH | grep -iq "g:deoplete#enable_at_startup = 1"; then
            sed -i '/^" AutoCompleteSettings.*/a let g:deoplete#enable_at_startup = 1' $INIT_VIM_PATH
        fi

        pip3 install --user jedi --upgrade
        pip3 install msgpack
    }

    if [ "$AUTOCOMPLE" = "coc" ]; then
        install_coc

    elif [ "$AUTOCOMPLE" = "jedi" ]; then
        install_jedi
    fi
    
}

function install_plug_plugin
{
    # Install Plugin that install Plugin :)
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    nvim +PlugClean! +PlugInstall +UpdateRemotePlugins +qall

    #install_coc
}

function install
{
    install_neovim
    install_requirements
    install_plug_plugin
    
}
"$@"
