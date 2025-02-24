set nocompatible
" Setup Vim-Plug
call plug#begin('~/.vim/plugged')

" Add all plugins here
Plug 'tmhedberg/SimpylFold'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'rhysd/vim-clang-format'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'

call plug#end()
filetype plugin indent on
syntax on

" General Settings
set encoding=utf-8
set number
set clipboard=unnamedplus
set background=light
colorscheme nord
set noshowmode
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set shortmess+=c
set signcolumn=number
set autochdir
set laststatus=2

" Indent Settings
set autoindent
set tabstop=4
set expandtab
set shiftwidth=4

" CusorLine Settings
set cursorline
hi CursorLine cterm=underline

" FILE SETTINGS
"
" Python Files Settings
autocmd FileType python map <buffer> <F5> <Esc>:! clear;python %<CR>

" C++ Files Settings
autocmd FileType cpp map <F5> <Esc>:!clear;./output<CR>
" c++ templates
autocmd BufNewFile *.cpp 0r ~/.vim/templates/c++/main.cpp
autocmd BufNewFile *.hpp 0r ~/.vim/templates/c++/header.hpp

" Shorcut Maps
nnoremap <C-s> :w<CR>
nnoremap <F4> :q<CR>
nnoremap <space> za

" CUSTOM COMMANDS
"
" VimConfig
command VimConfig execute "e $MYVIMRC"
" ZshConfig
command ZshConfig execute "e ~/.zshrc"
" ZshEnv
command ZshEnv execute "e ~/.zshenv" 

" PLUGINS SETTINGS
"
" Clang Format Settings
let g:clang_format#auto_format=1

" IndentLine Settings
let g:indentLine_color_term=8
let g:indentLine_char='│'

" COC_NVIM Settings
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col -1] =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Lightline Settings
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
    \ },
    \ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
