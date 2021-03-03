set nocompatible     "makes vimrc work
set backspace=2      "makes backspace work
colorscheme seoul256 "colorscheme
set number           "line numbers
set tabstop=4 shiftwidth=4 encoding=utf-8 noexpandtab "tabs are good
set smarttab		 "aligns to space when tabbing
set autoindent       "copy indent from above line
set hlsearch 	     "highlight search
set incsearch 	     "highlight search while typing
set showmatch		 "show matching brackets
set history=50		 "stores last 50 commands
set ignorecase		 "search ignores case sensitive
set autoindent		 "copies indentation from previous line. TODO check if you like this
set mouse=a 		 "allows mouse actions
set ruler 		 	 "shows cursor position
set viminfo= 		 "no viminfo
set encoding=utf8 	 "non-ascii characters are encoded with utf8 by default
set showcmd 		 "show length of visual selections
set complete=.,w,b,u "makes autocomplete faster
set splitright 		 "creates vertical splits to the right
set splitbelow 		 "creates horizontal splits below
set tabpagemax=30 	 "show up to 30 tabs
set wrap 			 "wrap lines to fit window
"set lazyredraw 		 "redraws the screen less often
filetype indent on	 "makes indents different for specific types
set showcmd			 "shows command in bottom no matter what
set cursorline		 "puts a line where the cursor is
set visualbell		 "blinks cursor instead of beeping
set wildmenu		 "autocomplete menu
set foldenable		 "allows folding of codeblocks
set foldlevelstart=10 "opens folds by default
set foldmethod=indent "folds based on indent (for python)
let g:netrw_mouse_maps=0 "ignore mouse clicks when browsing directories

"Vim will no longer skip the 'fake' wrapped lines
noremap j gj
noremap k gk

"tab in normal mode will insert a tab character
noremap <F5> i<tab><Esc>

"help on some function
map <F1> :h 
"open a in a new tab
map <F2> :tabe 
"save current
map <F3> :w<CR>
"quit
map <F4> :q!<CR> 
"search command
map <F7> :%s, 
"stop highlighting search
map <F8> :noh<CR>
"left bracket switch to left tab
nnoremap <s-tab> gT 
"right bracket switch to right tab
nnoremap <tab> gt 
"vnoremap <F5> "+y
"vnoremap <F6> "*y
"vnoremap ^P "*y
command Newc :normal i#include <stdio.h><CR>#include <stdlib.h><CR>#include <stdbool.h><CR>#include <assert.h><CR><CR>int main(int argc, char* argv[]) {<CR><CR>}<C-Up><tab>
