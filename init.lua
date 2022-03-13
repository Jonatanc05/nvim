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
	use 'embark-theme/vim'                            -- Colorscheme
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


------------ Legacy stuff -----------

local init_path = vim.fn.stdpath('config')

vim.cmd('source ' .. init_path .. '/old-init.vim')
vim.cmd('source ' .. init_path .. '/keymap.vim')
vim.cmd('source ' .. init_path .. '/plug-config.vim')


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

