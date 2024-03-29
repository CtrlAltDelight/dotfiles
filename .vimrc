" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
" .vimrc file
"
" vim: set tabstop=4 shiftwidth=4 fileencoding=utf8 expandtab:
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
" ------------ PLUGINS ------------ "
" Search for vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" For Mac/Linux users Plug all plugins
call plug#begin('~/.vim/bundle')
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-plug'
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
"Plug 'ninegrid/vim-supertab'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/sonokai'
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'vim-scripts/summerfruit256.vim'
call plug#end()

" ------------ PLUGIN SETTINGS ------------ "
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFocus<CR>

" Set this. Airline will handle the rest. Ale integration with airline
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1 " Always have the ALE gutter open
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" Set this in your vimrc file to disabling highlighting
"let g:ale_set_highlights = 0

" Going between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ------------ OPTIONS ------------ "
set nocompatible                                      " makes vimrc work
set background=dark                                   " sets colorscheme to dark mode
let g:gruvbox_contrast_dark = 'soft'                  " makes more contrast to background with gruvbox colorscheme
colorscheme gruvbox                                   " colorscheme
filetype indent on                                    " makes indents different for specific types
let mapleader = ";"                                   " map leader to semicolon
set backspace=2                                       " makes backspace work
set number                                            " line numbers
set tabstop=4 shiftwidth=4 encoding=utf-8 noexpandtab " tabs are good
set smarttab                                          " aligns to space when tabbing
set autoindent                                        " copy indent from above line
set hlsearch                                          " highlight search
set incsearch                                         " highlight search while typing
set showmatch                                         " show matching brackets
set history=50                                        " stores last 50 commands
set ignorecase                                        " search ignores case sensitive
set autoindent                                        " copies indentation from previous line. TODO check if you like this
set mouse=a                                           " allows mouse actions
set ruler                                             " shows cursor position
set viminfo=                                          " no viminfo
set encoding=utf8                                     " non-ascii characters are encoded with utf8 by default
set showcmd                                           " show length of visual selections
set complete=.,w,b,u                                  " makes autocomplete faster
set splitright                                        " creates vertical splits to the right
set splitbelow                                        " creates horizontal splits below
set tabpagemax=30                                     " show up to 30 tabs
set wrap                                              " wrap lines to fit window
set lazyredraw                                        " redraws the screen less often
set showcmd                                           " shows command in bottom no matter what
set cursorline                                        " puts a line where the cursor is
set visualbell                                        " enables visual bell
set t_vb=                                             " turns off the visual bell
set wildmenu                                          " autocomplete menu
set foldenable                                        " allows folding of codeblocks
set foldlevelstart=10                                 " opens folds by default
set foldmethod=indent                                 " folds based on indent (for python)
let g:netrw_mouse_maps=0                              " ignore mouse clicks when browsing directories
set timeoutlen=2500                                   " makes the timeout a bit longer (2.5 seconds)
set timeoutlen=1000 ttimeoutlen=0                     " disable escape keys (faster shift+o)
set colorcolumn=100

" ------------ MAPPINGS ------------ "
" Vim will no longer skip the 'fake' wrapped lines
noremap j gj
noremap k gk

" ga is used to see the ascii value at the cursor. set this functionality to
" gs instead because ga is reserved for EasyAlign
nnoremap gs ga

" insert mode F5 will be underscore (saves overusing the pinky)
inoremap <F5> _

" help on some function
map <F1> :h 

" open a new tab
map <F2> :tabe 

" save current
map <F3> :w<CR>

" exit
map <F4> :q<CR>

" exit without saving
map <S-F4> :q!<CR>

" search command
map <F7> :?

" stop highlighting search
map <F8> :noh<CR>

" run current python3 program
map <F11> :w<CR>:!python3 %<CR>

" run current C program
map <F12> :w<CR>:!gcc -o placeholder % && ./placeholder && rm -f placeholder<CR>

" ';' same as ':'
nmap ; :

" ' ' same as ':'
nmap <SPACE> :

" tab key advances tab
nnoremap <tab> gt 

" shift+tab goes back a tab
nnoremap <s-tab> gT 

" autocomplete, backwards
imap <F3> <C-P>

" autocomplete, forwards
imap <F4> <C-N>

" ------------ COMMANDS ------------ "
" writes boilerplate code for a new C file
command Newc :normal i#include <stdio.h><CR>#include <stdlib.h><CR>#include <stdbool.h><CR>#include <string.h><CR>#include <assert.h><CR><CR>int main(int argc, char* argv[]) {<CR><CR>return EXIT_SUCCESS;<CR>}<CR>/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */<C-Up><C-Up><C-Up><tab>

"make 256 colors work in the kitty terminal emulator
let &t_ut=''

