-- strongly advised from vim tree:
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd('set termguicolors') -- for nvim-colorizer




-- LAZY PACKAGE MANAGER --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
	"git",
	"clone",
	"--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable", -- latest stable release
	lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Colorschemes
	{ "ellisonleao/gruvbox.nvim", lazy=true }, -- lazy means it will load when the colorscheme is selected
	{ "catppuccin/nvim", lazy=true },--, opts={ integrations={ gitsigns=true, nvimtree=true, telescope=true } }, config=true },
	{ "folke/tokyonight.nvim", lazy=true },
	{ "shaunsingh/nord.nvim", lazy=true },
	{ "marko-cerovac/material.nvim", lazy=true },
	{ "shaunsingh/seoul256.nvim", lazy=true},

	-- Pleasing Plugins
	{ "folke/drop.nvim", name="drop", opts={theme="snow"},config=true }, -- makes snow fall when idle in nvim
	{ "goolord/alpha-nvim", name="alpha", dependencies={ "nvim-tree/nvim-web-devicons" }, opts, config=function()require("alpha").setup(require'alpha.themes.dashboard'.config)end }, -- customizable neovim greeter
	{ "nvim-lualine/lualine.nvim", name="lualine", dependencies='nvim-tree/nvim-web-devicons', config=true }, -- nvim version of airline

	-- Useful plugins
	{ "iamcco/markdown-preview.nvim", name="markdown-preview", build=function() vim.fn["mkdp#util#install"]() end, config=function() vim.g.mkdp_filetypes = { "markdown" }; vim.g.mkdp_browser='/usr/bin/firefox' end, ft="markdown" }, -- use <leader>mp to view the current markdown file
	{ "junegunn/vim-easy-align", name="easy-align"}, -- use gaip to align the current block of code
	{ "nvim-lua/plenary.nvim", name="plenary" }, -- telescope dependency, a library for neovim plugins
	{ "nvim-telescope/telescope.nvim", name="telescope", dependencies={ "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" } }, -- need to install sharkdp/fd and BurntSushi/ripgrep on your machine, fuzzy finder and searcher
	{ "nvim-treesitter/nvim-treesitter", name="treesitter", build=":TSUpdate", name="nvim-treesitter", config=function() require'nvim-treesitter.configs'.setup { parser_install_dir = "~/.config/nvim/nvim-data/lazy/nvim-treesitter",highlight = { enable = true, additional_vim_regex_highlighting = false}, }end }, -- accurate syntax hilighting, indentation, and other editing features
	{ "windwp/nvim-autopairs", name="nvim-autopairs", config=true }, -- automatically pairs quotes, parenthesis, brackets etc.
	{ "lewis6991/gitsigns.nvim", name="gitsigns", config=true }, -- git decoations for added, removed, and changed lines
	{ "numToStr/Comment.nvim", name="Comment", config=true }, -- binds gcc toggle comment for current line
	{ "norcalli/nvim-colorizer.lua", name="colorizer", opts = {'*'}, config = true }, -- Highlights the background of color codes eg: #558817
	{ "lukas-reineke/indent-blankline.nvim", name="indent_blankline", opts={show_current_context = true, show_current_context_start = true}, config=true}, -- adds indentation guides
	{ "nvim-tree/nvim-tree.lua", name="tree", dependencies={"nvim-tree/nvim-web-devicons"}, name="nvim-tree", opts={ sort_by = "case_sensitive", view = {width = 30,}, renderer = {group_empty = true,},filters = {dotfiles = true,},}, config=true }, -- file explorer
	{ "neoclide/coc.nvim", name="coc", branch="release" }, -- autocomplete
})

-- VIM SETTINGS --
vim.cmd('colorscheme catppuccin')            -- colorscheme
vim.cmd('filetype indent on')                -- makes indents different for specific types
vim.cmd('let mapleader = " "')               -- map leader to space
vim.cmd('set backspace=2')                   -- makes backspace work
vim.cmd('set number')                        -- line numbers
vim.cmd('set relativenumber')                        -- relative line numbers
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set encoding=utf-8')
vim.cmd('set noexpandtab')                   -- tabs are good
vim.cmd('set smarttab')                      -- aligns to space when tabbing
vim.cmd('set autoindent')                    -- copy indent from above line
vim.cmd('set hlsearch')                      -- highlight search
vim.cmd('set incsearch')                     -- highlight search while typing
vim.cmd('set showmatch')                     -- show matching brackets
vim.cmd('set history=50')                    -- stores last 50 commands
vim.cmd('set ignorecase')                    -- search ignores case sensitive
vim.cmd('set autoindent')                    -- copies indentation from previous line. TODO check if you like this
vim.cmd('set ruler')                         -- shows cursor position
vim.cmd('set encoding=utf8')                 -- non-ascii characters are encoded with utf8 by default
vim.cmd('set showcmd')                       -- show length of visual selections
vim.cmd('set complete=.,w,b,u')              -- makes autocomplete faster
vim.cmd('set splitright')                    -- creates vertical splits to the right
vim.cmd('set splitbelow')                    -- creates horizontal splits below
vim.cmd('set tabpagemax=30')                 -- show up to 30 tabs
vim.cmd('set wrap')                          -- wrap lines to fit window
vim.cmd('set lazyredraw')                    -- redraws the screen less often
vim.cmd('set showcmd')                       -- shows command in bottom no matter what
vim.cmd('set cursorline')                    -- puts a line where the cursor is
vim.cmd('set visualbell')                    -- enables visual bell
vim.cmd('set t_vb=')                         -- turns off the visual bell
vim.cmd('set wildmenu')                      -- autocomplete menu
vim.cmd('set foldenable')                    -- allows folding of codeblocks
vim.cmd('set foldlevelstart=10')             -- opens folds by default
vim.cmd('set foldmethod=indent')             -- folds based on indent (for python)
vim.cmd('let g:netrw_mouse_maps=0')          -- ignore mouse clicks when browsing directories
vim.cmd('set timeoutlen=2500')               -- makes the timeout a bit longer (2.5 seconds)
vim.cmd('set timeoutlen=1000 ttimeoutlen=0') -- disable escape keys (faster shift+o)
vim.cmd('set colorcolumn=100')               -- places a column at X characters into the file



-- MAPPINGS --
function map(mode, lhs, rhs, opts)
local options = { noremap = true }
if opts then -- see :h map-arguments for more info
	options = vim.tbl_extend("force", options, opts)
end
vim.keymap.set(mode, lhs, rhs, options)
end

-- F keys
map("n", "<F1>", ":h ")                                                                     -- help on some function
map("n", "<F2>", ":tabe ")                                                                  -- open a file in a new tab
map("n", "<F3>", ":w<CR>")                                                                  -- save current file
map("n", "<F4>", ":q<CR>")                                                                  -- close current file
map("n", "<S-F4>", ":q!<CR>")                                                               -- close current file (without saving!)
map("n", "<F8>", ":noh<CR>")                                                        -- stop highlight search
map("n", "<F11>", "!make")                                                                  -- run first make rule/target
map("n", "<F12>", ":w<CR>:!gcc -o placeholder % -lm && ./placeholder && rm -f placeholder<CR>") -- run current C file (Does not work for multiple files)
map('n', '<leader>0', ":tabe ~/.config/nvim/init.lua<CR>", {}) -- open init.lua

-- Quality of Life
map("n", ";", ":")        -- saves on pressing shift for :

-- Easy Align
map("n", "ga", "<Plug>(EasyAlign)") -- activate easy align. Tip: use gaip to select the inner paragraph for easy align

-- Telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, {}) -- find file
map('n', '<leader>fg', builtin.live_grep, {}) -- find grep
vim.keymap.set('n', '<leader>fb', builtin.buffers, {}) -- find buffer
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {}) -- find help tags

-- Lazy
map('n', '<leader>l', ":Lazy<CR>", {})

-- Comment
map('n', '<leader>cc', "gcc", {})

-- Tree
map('n', '<leader>tt', ":NvimTreeToggle<CR>", {})
map('n', '<leader>tf', ":NvimTreeFocus<CR>", {})
map('n', '<leader>tc', ":NvimTreeCollapse<CR>", {})

-- Markdown Preview
map('n', '<leader>mp', ":MarkdownPreview<CR>", {}) -- markdown preview
map('n', '<leader>ms', ":MarkdownPreviewStop<CR>", {}) -- markdown stop
map('n', '<leader>mt', ":MarkdownPreviewToggle<CR>", {}) -- markdown toggle

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- user-defined commands --
vim.api.nvim_create_user_command('Newc', ":normal i#include <stdio.h><CR>#include <stdlib.h><CR>#include <stdbool.h><CR>#include <string.h><CR>#include <assert.h><CR><CR>int main(int argc, char* argv[]) {<CR><CR>return EXIT_SUCCESS;<CR>}<CR>/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */<C-Up><C-Up><C-Up><tab>", {}) -- inserts boilerplate for a new C program




-- Auto complete
-- coc settings
-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply code actions affect whole buffer.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Remap keys for applying codeActions to the current buffer
keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)




-- Treat svelte files as HTML
-- (Since treesitter does not have a parser for svelte files)
vim.cmd([[
  augroup SvelteFileType
    autocmd!
    autocmd BufNewFile,BufRead *.svelte set filetype=html
  augroup END
]])

-- Art for alpha-nvim homescreen:
local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
'                                        ,   ,                                   ',
'                                        $,  $,     ,                            ',
'                                        "ss.$ss. .s                             ',
'                                ,     .ss$$$$$$$$$$s,                           ',
'                                $. s$$$$$$$$$$$$$$`$$Ss                         ',
'                                "$$$$$$$$$$$$$$$$$$o$$$       ,                 ',
'                               s$$$$$$$$$$$$$$$$$$$$$$$$s,  ,s                  ',
'                              s$$$$$$$$$"$$$$$$""""$$$$$$"$$$$$,                ',
'                              s$$$$$$$$$$s""$$$$ssssss"$$$$$$$$"                ',
'                             s$$$$$$$$$$\'         `"""ss"$"$s""                ',
'                             s$$$$$$$$$$,              `"""""$  .s$$s           ',
'                             s$$$$$$$$$$$$s,...               `s$$\'  `         ',
'                         `ssss$$$$$$$$$$$$$$$$$$$$####s.     .$$"$.   , s-      ',
'                           `""""$$$$$$$$$$$$$$$$$$$$#####$$$$$$"     $.$\'      ',
'                                 "$$$$$$$$$$$$$$$$$$$$$####s""     .$$$|        ',
'                                  "$$$$$$$$$$$$$$$$$$$$$$$$##s    .$$" $        ',
'                                   $$""$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"   `       ',
'                                  $$"  "$"$$$$$$$$$$$$$$$$$$$$S"""\'            ',
'                             ,   ,"     \'  $$$$$$$$$$$$$$$$####s               ',
'                             $.          .s$$$$$$$$$$$$$$$$$####"               ',
'                 ,           "$s.   ..ssS$$$$$$$$$$$$$$$$$$$####"               ',
'                 $           .$$$S$$$$$$$$$$$$$$$$$$$$$$$$#####"                ',
'                 Ss     ..sS$$$$$$$$$$$$$$$$$$$$$$$$$$$######""                 ',
'                  "$$sS$$$$$$$$$$$$$$$$$$$$$$$$$$$########"                     ',
'           ,      s$$$$$$$$$$$$$$$$$$$$$$$$#########""\'                        ',
'           $$..$$$$$$$$$$$$$$$$$$######"\'       ....,$$....    ,$              ',
'            "$$$$$$$$$$$$$$$######"\' ,     .sS$$$$$$$$$$$$$$$$s$$              ',
'              $$$$$$$$$$$$#####"     $, .s$$$$$$$$$$$$$$$$$$$$$$$$s.            ',
'   )          $$$$$$$$$$$#####\'      `$$$$$$$$$###########$$$$$$$$$$$.         ',
'  ((          $$$$$$$$$$$#####       $$$$$$$$###"       "####$$$$$$$$$$         ',
'  ) \\         $$$$$$$$$$$$####.     $$$$$$###"             "###$$$$$$$$$   s\' ',
' (   )        $$$$$$$$$$$$$####.   $$$$$###"                ####$$$$$$$$s$$\'   ',
' )  ( (       $$"$$$$$$$$$$$#####.$$$$$###\'                .###$$$$$$$$$$"     ',
' (  )  )   _,$"   $$$$$$$$$$$$######.$$##\'                .###$$$$$$$$$$       ',
' ) (  ( \\.         "$$$$$$$$$$$$$#######,,,.          ..####$$$$$$$$$$$"       ',
'(   )$ )  )        ,$$$$$$$$$$$$$$$$$$####################$$$$$$$$$$$"          ',
'(   ($$  ( \\     _sS"  `"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$S$$,         ',
' )  )$$$s ) )  .      .   `$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"\'  `$$        ',
'  (   $$$Ss/  .$,    .$,,s$$$$$$##S$$$$$$$$$$$$$$$$$$$$$$$$S""        \'        ',
'    \\)_$$$$$$$$$$$$$$$$$$$$$$$##"  $$        `$$.        `$$.                  ',
'        `"S$$$$$$$$$$$$$$$$$#"      $          `$          `$                   ',
'            \\`"""""""""""""\'         \'           \'           \'             ',

}

