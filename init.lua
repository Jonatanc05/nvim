-------- Global and helper stuff --------
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

------- Install packer and plugins -------

local install_path = data_path .. '/site/pack/packer/start/packer.nvim'
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
	use 'wbthomason/packer.nvim'                      -- Packer itself
	use 'mhinz/vim-startify'                          -- Initial screen
	use 'derekwyatt/vim-fswitch'                      -- Switch header-source file (c++)
--	use 'embark-theme/vim'                            -- Colorscheme
	use 'dikiaap/minimalist'                          -- Colorscheme (includes custom config in Legacy section of this file)
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'airblade/vim-rooter'                         -- Find root directory of project
	use 'mhinz/vim-signify'                           -- Git signs lines
	use 'tpope/vim-fugitive'                          -- :Git commands
	use 'tpope/vim-rhubarb'                           -- :GBrowser to github
    use {
		'nvim-treesitter/nvim-treesitter',
		tag = 'v0.8.5.2',
		run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
--	use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter
	use 'neovim/nvim-lspconfig'                       -- Collection of configurations for built-in LSP client
	use 'williamboman/mason.nvim'                     -- Manager for my LSPs
	use 'williamboman/mason-lspconfig.nvim'           -- Mason integration with lspconfig
--	use 'nvim-lualine/lualine.nvim'                   -- Fancier statusline
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'Exafunction/codeium.vim'
	use {
		'nvim-tree/nvim-tree.lua',                    -- File tree on a sidebar
		requires = { 'nvim-tree/nvim-web-devicons' }, -- optional, only for icons
		--tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
end)

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






-------------- Key Maps -------------

vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<C-q>",     ":bd<CR>", {})
vim.api.nvim_set_keymap("n", "<C-Q>",     ":bd!<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", {})
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

-- LSP mappings
vim.api.nvim_set_keymap("n", "K",         "<cmd>lua vim.lsp.buf.hover()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
--vim.api.nvim_set_keymap("n", "gD",        "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
vim.api.nvim_set_keymap("n", "gd",        ":vsp<CR><cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gs",        "<cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gc",        ":sp<CR><cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gi",        ":vsp<CR><cmd>lua vim.lsp.buf.implementation()<CR>", {})
vim.api.nvim_set_keymap("n", "gr",        "<cmd>lua vim.lsp.buf.references()<CR>", {})
vim.api.nvim_set_keymap("n", "g[",        "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
vim.api.nvim_set_keymap("n", "g]",        "<cmd>lua vim.diagnostic.goto_next()<CR>", {})
vim.api.nvim_set_keymap("n", "<A-CR>",    "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", {})


-- Completion mappings
completion_mappings = {
	['<C-b>']     = cmp_plugin.mapping.scroll_docs(-4),
	['<C-f>']     = cmp_plugin.mapping.scroll_docs(4),
	['<C-Space>'] = cmp_plugin.mapping.complete(),
	['<C-e>']     = cmp_plugin.mapping.abort(),
	['<Tab>']     = cmp_plugin.mapping.confirm({ select = true }),
	['<CR>']      = cmp_plugin.mapping.confirm({ select = false }),
}





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
	ensure_installed = {"c_sharp", "c", "cpp", "lua", "javascript", "css", "html", "markdown", "vue", "typescript"},
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	}
}






------------- Setup Neovim Tree -------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require'nvim-tree'.setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				-- :help nvim-tree-mappings
				{ key = { "<C-i>" }, action = "cd" },
			},
		},
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







------ Setup completion + builtin LSPs ------

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
if lspconfig.volar then
	--add_to_path();
	lspconfig.volar.setup {
		cmd = {data_path .. '\\mason\\packages\\vue-language-server\\node_modules\\.bin\\vue-language-server.cmd', '--stdio'},
		filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
		init_options = { typescript = { tsdk = data_path .. '/mason/packages/vue-language-server/node_modules/typescript/lib' } },
		capabilities = cmp_capabilities
	}
end

-- Omnisharp
if lspconfig.omnisharp then
	lspconfig.omnisharp.setup {
		use_mono = string.find(vim.fn.getcwd(), "GEO_ESB") ~= nil, -- Only use mono in the Pozzo project
		sdk_include_prereleases = false,
		capabilities = cmp_capabilities,
	}
end

-- Rust
if lspconfig.rust_analyzer then
	lspconfig.rust_analyzer.setup{
		settings = {
			['rust-analyzer'] = {
				diagnostics = {
					enable = true
				}
			}
		},
		capabilities = cmp_capabilities
	}
end

-- Clangd
if lspconfig.clangd then
	lspconfig.clangd.setup {
		capabilities = cmp_capabilities,
	}
end

-- Zig
if lspconfig.zls then
	lspconfig.zls.setup {
		path = data_path .. '\\mason\\bin\\zls.cmd',
		capabilities = cmp_capabilities,
		enableBuildOnSave = true,
	}
end

