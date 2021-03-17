-- Gereral settings
vim.api.nvim_set_option('clipboard','unnamed,unnamedplus') -- Copy/Paste directly to System/X11 clipboard
vim.api.nvim_set_option('incsearch') -- Mark the words during search
vim.api.nvim_set_option('number') -- Add number line
vim.api.nvim_set_option('shell', '/usr/bin/zsh') -- Add number line
vim.api.nvim_set_option('tabstop', 4) -- tab will insert 4 space



-- Plugins
vim.cmd 'packadd paq-nvim'         -- Load package
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function
paq{'savq/paq-nvim', opt=true}     -- Let Paq manage itself

paq 'vim-airline/vim-airline'
paq 'vim-airline/vim-airline-themes'



--set tabstop=4		" tab will insert 4 space
--set shiftwidth=4	" when indeting the '>', use 4 space
--set expandtab		" on pressing tab, insert 4 spaces

--call plug#begin('~/.local/share/nvim/plugged')

--" AutoCompletePlugin
 
--call plug#end()

--" AutoCompleteSettings

