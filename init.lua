	-- strongly advised from vim tree:
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- WINDOWS
	--vim.cmd('let $TMP="/tmp"')
	vim.cmd('let &shell=\'"C:\\Program Files\\Git\\bin\\bash.exe"\'')
	--vim.cmd('let &shell=\'MINGW64:/usr/bin/bash\'')

	-- VIM SETTINGS --
	vim.cmd('colorscheme habamax')               -- colorscheme
	vim.cmd('filetype indent on')                -- makes indents different for specific types
	vim.cmd('let mapleader = " "')               -- map leader to semicolon
	vim.cmd('set backspace=2')                   -- makes backspace work
	vim.cmd('set number')                        -- line numbers
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
	vim.cmd('set visualbell')                   -- enables visual bell
	vim.cmd('set t_vb=')                         -- turns off the visual bell
	vim.cmd('set wildmenu')                      -- autocomplete menu
	vim.cmd('set foldenable')                    -- allows folding of codeblocks
	vim.cmd('set foldlevelstart=10')             -- opens folds by default
	vim.cmd('set foldmethod=indent')             -- folds based on indent (for python)
	vim.cmd('let g:netrw_mouse_maps=0')          -- ignore mouse clicks when browsing directories
	vim.cmd('set timeoutlen=2500')               -- makes the timeout a bit longer (2.5 seconds)
	vim.cmd('set timeoutlen=1000 ttimeoutlen=0') -- disable escape keys (faster shift+o)
	vim.cmd('set colorcolumn=100')               -- places a column at X characters into the file

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
		{ "ellisonleao/gruvbox.nvim", lazy=true }, -- lazy means it will load when the colorscheme is selected
		{"folke/drop.nvim", name="drop", opts={theme="stars"},config=true},
		{"junegunn/vim-easy-align"},
		{"nvim-lua/plenary.nvim"}, -- telescope dependency
		{"nvim-treesitter/nvim-treesitter", name="nvim-treesitter", config=function() require'nvim-treesitter.configs'.setup {parser_install_dir = "~/AppData/Local/nvim-data/lazy/nvim-treesitter",highlight = {enable = true,disable = { "c", "rust" },additional_vim_regex_highlighting = false,},}end},
		{ "hrsh7th/nvim-cmp", name="nvim-cmp", dependencies={"hrsh7th/vim-vsnip", "hrsh7th/cmp-nvim-lsp", "hrsh7th/nvim-lspconfig"} }, -- autocomplete, useful keys are <C-n> for next and <C-p> for previous
		--{"nvim-lua/completion-nvim", dependencies={"steelsojka/completion-buffers", "neovim/nvim-lspconfig"}},
		{ "nvim-telescope/telescope.nvim", dependencies={"nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim"} }, -- need to install sharkdp/fd and BurntSushi/ripgrep on your machine
		{"windwp/nvim-autopairs", name="nvim-autopairs", config=true}, -- automatically pairs quotes, parenthesis, brackets etc.
		{"lewis6991/gitsigns.nvim", name="gitsigns", config=true}, -- git decoations for added, removed, and changed lines
		{"numToStr/Comment.nvim", name="Comment", config=true}, -- gcc toggle comment for current line
		"norcalli/nvim-colorizer.lua", -- Highlights the background of color codes eg: #558817
		{ "goolord/alpha-nvim", dependencies={"nvim-tree/nvim-web-devicons"}, name="alpha", config=function()require("alpha").setup(require'alpha.themes.dashboard'.config)end }, -- customizable neovim greeter
		{"lukas-reineke/indent-blankline.nvim", name="indent_blankline", opts={show_current_context = true, show_current_context_start = true}, config=true}, -- adds indentation guides
		{"nvim-tree/nvim-tree.lua", dependencies={"nvim-tree/nvim-web-devicons"}, name="nvim-tree", opts={sort_by = "case_sensitive",view = {width = 30,mappings = {list = {{ key = "u", action = "dir_up" },},},},renderer = {group_empty = true,},filters = {dotfiles = true,},}, config=true}, -- file explorer
		{"neoclide/coc.nvim", branch="release"},
})

--coc
vim.cmd('let g:coc_node_path=\'"C:\\Program Files\\Git\\bin\\bash.exe" -c -l\'')




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
map("n", "<F8>", ":nohighlight<CR>")                                                        -- stop highlight search
map("n", "<F11>", "!make")                                                                  -- run first make rule/target
map("n", "<F12>", ":w<CR>:!gcc -o placeholder % && ./placeholder && rm -f placeholder<CR>") -- run current C file (Does not work for multiple files)
map('n', '<leader>0', ":tabe ~/AppData/Local/nvim/init.lua<CR>", {}) -- open init.lua

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

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

-- Autopair
require("nvim-autopairs").setup {}

-- Gitsigns
require('gitsigns').setup()

-- tree sitter
require 'nvim-treesitter.install'.compilers = { "clang" }
require 'nvim-treesitter.install'.prefer_git = false

-- user-defined commands --
vim.api.nvim_create_user_command('Newc', ":normal i#include <stdio.h><CR>#include <stdlib.h><CR>#include <stdbool.h><CR>#include <string.h><CR>#include <assert.h><CR><CR>int main(int argc, char* argv[]) {<CR><CR>return EXIT_SUCCESS;<CR>}<CR>/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */<C-Up><C-Up><C-Up><tab>", {}) -- inserts boilerplate for a new C program
