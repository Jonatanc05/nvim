-------- INDEX --------

-- Global_and_helper_stuff
-- Install_packer_and_plugins
-- General
-- Key_Maps
--     LSP_mappings
--     Completion_mappings
-- Legacy_stuff
-- Treesitter
-- Setup_Neovim_Tree
-- Setup_completion_and_builtin_LSPs

-------- Global_and_helper_stuff --------
local data_path = vim.fn.stdpath('data')
windows = jit and jit.os == 'Windows'

local function add_to_path(new_path)
	local path = os.getenv("PATH")
	local path_sep = package.config:sub(1,1) == '\\' and ';' or ':'
	if not string.find(path, new_path, 1, true) then
		path = new_path .. path_sep .. path
		if windows then
			os.execute('setx PATH "' .. path .. '"')
		else
			os.execute('export PATH="' .. path .. '"')
		end
	end
end

------- Install_packer_and_plugins -------

local lazypath = data_path .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup( {
  "folke/lazy.nvim",
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  "mhinz/vim-startify",
  "derekwyatt/vim-fswitch",						-- Switch header-source file (c++)
  "dikiaap/minimalist",							-- Colorscheme
--	"embark-theme/vim'							-- Colorscheme
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  "airblade/vim-rooter",
  "tpope/vim-fugitive",							-- Git controls
  "mhinz/vim-signify",							-- Git signs on sidebar
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
--	"nvim-treesitter/nvim-treesitter-textobjects"			-- Create motions for functions

  -- LSP and completion
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline" }},
  "Exafunction/codeium.vim",
})
local cmp_plugin = require'cmp'






-------------- General --------------

vim.cmd 'colorscheme     minimalist'
vim.opt.number         = true
vim.opt.hidden         = true
vim.opt.wrap           = false
vim.opt.smartindent    = true
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.cursorline     = true
vim.opt.incsearch      = true
vim.opt.showcmd        = true
vim.opt.encoding       = "utf-8"
vim.opt.fileencoding   = "utf-8"
vim.opt.cmdheight      = 2
vim.opt.mouse          = "a"
vim.opt.splitbelow     = true
vim.opt.splitright     = true
vim.opt.compatible     = false
vim.opt.relativenumber =  true
vim.opt.switchbuf      = 'split'






-------------- Key_Maps -------------

vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>fd", ":Telescope find_files<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", {})
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
vim.api.nvim_set_keymap("n", "<C-k>",     ":resize -2<CR>", {})
vim.api.nvim_set_keymap("n", "<C-j>",     ":resize +2<CR>", {})
vim.api.nvim_set_keymap("n", "<C-h>",     ":vertical resize -2<CR>", {})
vim.api.nvim_set_keymap("n", "<C-l>",     ":vertical resize +2<CR>", {})
vim.api.nvim_set_keymap("n", "ç",         "/", {})
vim.api.nvim_set_keymap("n", "Ç",         "?", {})
vim.api.nvim_set_keymap("i", "<S-CR>",    "<CR>}<Esc>O", {})
vim.api.nvim_set_keymap("x", "<C-c>",     '"+y', {})
vim.api.nvim_set_keymap("x", "<C-x>",     '"+d', {})
vim.api.nvim_set_keymap("x", "<C-v>",     '"+P', {})
vim.api.nvim_set_keymap("v", "p",         '"_dP', {})
vim.api.nvim_set_keymap("i", "<C-BS>",    "<C-W>", {})
vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<CR>", {})
vim.api.nvim_set_keymap("n", "<F2>",      ":tabe<bar>vsplit<bar>term<CR><C-w>h:bd<CR>", {})
vim.api.nvim_set_keymap("n", "<C-1>",     "1gt", {})
vim.api.nvim_set_keymap("n", "<C-2>",     "2gt", {})
vim.api.nvim_set_keymap("n", "<C-3>",     "3gt", {})
vim.api.nvim_set_keymap("n", "<C-4>",     "4gt", {})
vim.api.nvim_set_keymap("n", "(",         "gT", {})
vim.api.nvim_set_keymap("n", ")",         "gt", {})
vim.api.nvim_set_keymap("n", "<C-0>",     ":let lnum = line('.') | let colnum = col('.') | tabe % | call cursor(lnum, colnum)<CR>gT:q<CR>gt", {})
vim.api.nvim_set_keymap('n', "<C-w><C-m>",":bd<CR>", {})
vim.api.nvim_set_keymap('n', "<leader>g", ":Gvsp<CR>", {})
vim.api.nvim_set_keymap('n', "g)", ":tabmove +1<CR>", {})
vim.api.nvim_set_keymap('n', "g(", ":tabmove -1<CR>", {})
vim.api.nvim_set_keymap('v', "<leader>q", ":norm i//<CR>", {})
vim.api.nvim_set_keymap('n', "<C-g>", ":0Gclog<CR>", {})
vim.api.nvim_set_keymap('n', "<Tab>", ":WintabsNext<CR>", {})
vim.api.nvim_set_keymap('n', "<S-Tab>", ":WintabsPrevious<CR>", {})

-- LSP_mappings
vim.api.nvim_set_keymap("n", "K",         "<cmd>lua vim.lsp.buf.hover()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
vim.api.nvim_set_keymap("n", "gD",        "<cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gd",        ":vsp<CR><cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gs",        "<cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gc",        ":sp<CR><cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gi",        ":vsp<CR><cmd>lua vim.lsp.buf.implementation()<CR>", {})
vim.api.nvim_set_keymap("n", "gr",        "<cmd>lua vim.lsp.buf.references()<CR>", {})
vim.api.nvim_set_keymap("n", "g[",        "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
vim.api.nvim_set_keymap("n", "g]",        "<cmd>lua vim.diagnostic.goto_next()<CR>", {})
vim.api.nvim_set_keymap("n", "<C-.>",    "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
vim.api.nvim_set_keymap("n", "]f", "/{<CR>%jzz", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[f", "?}<CR>%kzz", {noremap = true, silent = true})


-- Completion_mappings
completion_mappings = {
	['<C-b>']     = cmp_plugin.mapping.scroll_docs(-4),
	['<C-f>']     = cmp_plugin.mapping.scroll_docs(4),
	['<C-Space>'] = cmp_plugin.mapping.complete(),
	['<C-e>']     = cmp_plugin.mapping.abort(),
--	['<Tab>']     = cmp_plugin.mapping.confirm({ select = true }),
	['<CR>']      = cmp_plugin.mapping.confirm({ select = false }),
}





------------ Legacy_stuff -----------

local init_path = vim.fn.stdpath('config')

vim.cmd('source ' .. init_path .. '/old-init.vim')
vim.cmd('source ' .. init_path .. '/plug-config.vim')
vim.cmd([[
let g:startify_bookmarks = [
	\ { 'i': ']] .. init_path .. [[/init.lua' },
\ ]

" Minimalist coloscheme adjusts
hi String         ctermfg=1                            guifg=#D6BF9C
hi Type           ctermfg=28                           guifg=#AFD787
hi Identifier                            cterm=NONE                             gui=NONE
hi Search                   ctermbg=8    cterm=NONE               guibg=#444444 gui=NONE
hi MatchParen               ctermbg=8    cterm=NONE               guibg=#444444 gui=NONE
hi StorageClass ctermfg=140 ctermbg=NONE cterm=NONE guifg=#AF87D7 guibg=NONE    gui=NONE
]])





-------------- Treesitter --------------

if windows then
	require 'nvim-treesitter.install'.compilers = { "clang" }
end

local configs = require'nvim-treesitter.configs'
configs.setup {
	ensure_installed = {
		"c_sharp", "c", "cpp", "diff", "lua", "javascript", "css",
		"html", "markdown", "vue", "typescript", "json", "yaml", "zig"
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	}
}






------------- Setup_Neovim_Tree -------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require'nvim-tree'.setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
	},
	update_focused_file = {
		enable = true,
		update_root = false,
		ignore_list = {},
	},
	renderer = {
		group_empty = true,
	}
})







------ Setup_completion_and_builtin_LSPs ------

-- Mason LSP Installer
require('mason').setup()
require('mason-lspconfig').setup()

-- Completion
cmp_plugin.setup({
	window = {
		completion = cmp_plugin.config.window.bordered(),
		documentation = cmp_plugin.config.window.bordered(),
	},
	mapping = cmp_plugin.mapping.preset.insert(completion_mappings),
	sources = cmp_plugin.config.sources(
		{{ name = 'nvim_lsp' }},
		{{ name = 'buffer' }}
	)
})
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
cmp_capabilities.textDocument.completion.completionItem.snippetSupport = false -- nao tenho certeza se funciona

-- Individual LSP setups
local lspconfig = require'lspconfig'

-- Volar
vim.lsp.config('volar', {
	cmd = {data_path .. '\\mason\\packages\\vue-language-server\\node_modules\\.bin\\vue-language-server.cmd', '--stdio'},
	filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
	init_options = { typescript = { tsdk = data_path .. '/mason/packages/vue-language-server/node_modules/typescript/lib' } },
	capabilities = cmp_capabilities
})

-- Omnisharp
vim.lsp.config('omnisharp', {
	use_mono = string.find(vim.fn.getcwd(), "GEO_ESB") ~= nil, -- Only use mono in the Pozzo project
	sdk_include_prereleases = false,
	capabilities = cmp_capabilities,
})

-- Clangd
vim.lsp.config('clangd', {
	capabilities = cmp_capabilities,
})

-- Zig
vim.lsp.config('zls', {
	cmd = { data_path .. '\\mason\\bin\\zls.cmd' },
	capabilities = cmp_capabilities,
	enableBuildOnSave = true,
})

