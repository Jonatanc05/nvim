windows = jit and jit.os == 'Windows'
------- Install packer and plugins -------

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd([[
	augroup Packer
	  autocmd!
	  autocmd BufWritePost init.lua PackerCompile
	augroup end
]])

require('packer').startup(function(use)
	use 'mhinz/vim-startify'                          -- Initial screen
	use 'derekwyatt/vim-fswitch'                      -- Switch header-source file (c++)
--	use 'embark-theme/vim'                            -- Colorscheme
	use 'dikiaap/minimalist'
	use 'junegunn/fzf.vim'                            -- FZF
	use 'junegunn/fzf'                                -- FZF
	use 'airblade/vim-rooter'                         -- Find root directory of project
	use 'mhinz/vim-signify'                           -- Git signs lines
	use 'tpope/vim-fugitive'                          -- :Git commands
	use 'tpope/vim-rhubarb'                           -- :GBrowser to github
	use 'nvim-treesitter/nvim-treesitter'             -- Highlight, edit, and navigate code using a fast incremental parsing library
--	use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter
	use 'neovim/nvim-lspconfig'                       -- Collection of configurations for built-in LSP client
--	use 'hrsh7th/nvim-cmp'                            -- Autocompletion plugin
--	use 'hrsh7th/cmp-nvim-lsp'                        -- Autocompletion complement?
--	use 'nvim-lualine/lualine.nvim'                   -- Fancier statusline
end)






-------------- General --------------

vim.cmd 'colorscheme   minimalist'
vim.opt.number       = true
vim.opt.hidden       = true
vim.opt.wrap         = false
vim.opt.smartindent  = true
vim.opt.tabstop      = 4
vim.opt.shiftwidth   = 4
vim.opt.cursorline   = true
vim.opt.incsearch    = true
vim.opt.showcmd      = true
vim.opt.encoding     = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.cmdheight    = 2
vim.opt.mouse        = "a"
vim.opt.splitbelow   = true
vim.opt.splitright   = true
vim.opt.compatible   = false






-------------- Key Maps -------------

vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>f", ":FZF<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>h", ":noh<CR>", {})
vim.api.nvim_set_keymap("v", "<",         "<gv", {})
vim.api.nvim_set_keymap("v", ">",         ">gv", {})
vim.api.nvim_set_keymap("i", "jk",        "<Esc>", {})
vim.api.nvim_set_keymap("i", "kj",        "<Esc>", {})
vim.api.nvim_set_keymap("v", "jk",        "<Esc>", {})
vim.api.nvim_set_keymap("v", "kj",        "<Esc>", {})
vim.api.nvim_set_keymap("t", "jk",        "<C-\\><C-n>", {})
vim.api.nvim_set_keymap("t", "kj",        "<C-\\><C-n>", {})
vim.api.nvim_set_keymap("n", "<TAB>",     ":bnext<CR>", {})
vim.api.nvim_set_keymap("n", "<S-TAB>",   ":bprevious<CR>", {})
vim.api.nvim_set_keymap("x", "K :move",   "'<-2<CR>gv-gv", {})
vim.api.nvim_set_keymap("x", "J :move",   "'>+1<CR>gv-gv", {})
vim.api.nvim_set_keymap("n", "<C-k>",     ":resize -2<CR>", {})
vim.api.nvim_set_keymap("n", "<C-j>",     ":resize +2<CR>", {})
vim.api.nvim_set_keymap("n", "<C-h>",     ":vertical resize -2<CR>", {})
vim.api.nvim_set_keymap("n", "<C-l>",     ":vertical resize +2<CR>", {})
vim.api.nvim_set_keymap("n", "ç",         "/", {})
vim.api.nvim_set_keymap("n", "Ç",         "?", {})
vim.api.nvim_set_keymap("i", "<S-CR>",    "<CR>}<Esc>O", {})
vim.api.nvim_set_keymap("x", "<C-c>",     '"+y', {})
vim.api.nvim_set_keymap("x", "<C-x>",     '"+d', {})
vim.api.nvim_set_keymap("x", "<C-v>",     '"+p', {})
vim.api.nvim_set_keymap("v", "<C-p>",     '"_dP', {})
vim.api.nvim_set_keymap("i", "<C-BS>",    "<C-W>", {})






------------ Legacy stuff -----------

local init_path = vim.fn.stdpath('config')

vim.cmd('source ' .. init_path .. '/old-init.vim')
vim.cmd('source ' .. init_path .. '/plug-config.vim')
vim.cmd([[
let g:startify_bookmarks = [
	\ { 'i': ']] .. init_path .. [[/init.lua' },
	\ { 'o': ']] .. init_path .. [[/old-init.vim' },
	\ { 'p': ']] .. init_path .. [[/plug-config.vim' },
\ ]
]])





-------------- Treesitter --------------

if windows then
	require 'nvim-treesitter.install'.compilers = { "clang" }
end

local configs = require'nvim-treesitter.configs'
configs.setup {
	ensure_installed = "maintained", -- Only use parsers that are maintained
	highlight = { -- enable highlighting
	  enable = true,
	},
	indent = {
	  enable = false,
	}
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"




------- Setup builtin LSPs -----------

local lspconfig = require('lspconfig')
local opts = { noremap = true, silent = true }

-- C#
local pid = vim.fn.getpid()
local omnisharp_bin = init_path .. "/language-servers/omnisharp-server/OmniSharp.exe"
lspconfig.omnisharp.setup{
	cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
	on_attach = function(_, buf)
		local map = function(press, cmd) vim.api.nvim_buf_set_keymap(buf, 'n', press, cmd, opts) end
		map('<C-K>',     '<cmd>lua vim.lsp.buf.hover()<CR>')
		map('<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>')
		map('gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>')
		map('gd',        '<cmd>lua vim.lsp.buf.definition()<CR>')
		map('gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>')
		map('gt',        '<cmd>lua vim.lsp.buf.type_definition()<CR>')
		map('gr',        '<cmd>lua vim.lsp.buf.references()<CR>')
		map('g[',        '<cmd>lua vim.diagnostic.goto_prev()<CR>')
		map('g]',        '<cmd>lua vim.diagnostic.goto_next()<CR>')
		map('<A-CR>',    '<cmd>lua vim.lsp.buf.code_action()<CR>')
	end
}

