" Gereral settings
set clipboard=unnamed,unnamedplus " Copy/Paste directly to System/X11 clipboard

"set hlsearch        " Highlight the word when search
set incsearch       " Start search in realtime

set number "Add number line
set tabstop=4		" tab will insert 4 space
set shiftwidth=4	" when indeting the '>', use 4 space
set expandtab		" on pressing tab, insert 4 spaces

call plug#begin('~/.local/share/nvim/plugged')

" AutoCompletePlugin
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
 
call plug#end()

" AutoCompleteSettings

