-------- INDEX --------
--[[
Global_and_helper_stuff
Treesitter
Nvimtree
Install_packer_and_plugins
General
Custom_switchbuf_on_quickfixlist
Key_Maps
    Plugin_mappings
    LSP_mappings
    Completion_mappings
Legacy_stuff
Completion_and_builtin_LSPs
]]

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






-------------- Treesitter --------------

local function treesitter_config()
  if windows then
    require 'nvim-treesitter.install'.compilers = { "clang" }
  end

  -- requires you to have the `tree-sitter-cli` package installed for some reason
  require'nvim-treesitter'.install({
    "c_sharp", "c", "cpp", "diff", "lua", "javascript", "css",
    "html", "markdown", "vue", "typescript", "json", "yaml", "zig"
  })
end





------------- Nvimtree -------------
local function nvimtree_config()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.opt.termguicolors = true

  local function nvimtree_on_attach(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "", api.tree.change_root_to_node,          opts("CD (Ctrl+])"))
  end

  require'nvim-tree'.setup({
    sort_by = "case_sensitive",
    on_attach = nvimtree_on_attach,
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
end







------- Install_packer_and_plugins -------

local lazypath = data_path .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim", lazypath })
end
vim.opt.rtp:prepend(lazypath)

local obsidian_vault_path
if (windows) then
  obsidian_vault_path = vim.fn.expand("~/Desktop/Pessoal/vault1/vault1")
else
  obsidian_vault_path = vim.fn.expand("~/Documents/vault1")
end
require("lazy").setup( {
  "folke/lazy.nvim",
  "airblade/vim-rooter",
  "tpope/vim-fugitive",
  "mhinz/vim-signify",
  "zefei/vim-wintabs",
  { "dikiaap/minimalist", priority = 90, },
  { "mhinz/vim-startify", priority = 80, },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "NvimTreeToggle",
    config = nvimtree_config,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
          },
        },
      })
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    ft = "markdown",
    -- event = {
    --   "BufReadPre " .. vim.fn.expand(obsidian_vault_path .. '/') .. "*.md",
    --   "BufNewFile " .. vim.fn.expand(obsidian_vault_path .. '/') .. "*.md",
    -- },
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp", "nvim-telescope/telescope.nvim" },
    opts = {
      workspaces = { { name = "personal", path = obsidian_vault_path } },
      daily_notes = { folder = "daily/2025" },
      notes_subdir = "zettelkasten/sea-of-notes",
      attachments = { img_folder = "assets" },
      mappings = {
        ["<C-n>"] = {
          action = function()
            return ":ObsidianNew zettelkasten/sea-of-notes/"
          end,
          opts = { noremap = true, expr = true, buffer = true },
        },
        ["<C-p>"] = {
          action = function()
            return ":ObsidianPasteImg"
          end,
          opts = { noremap = true, expr = true, buffer = true },
        },
        ["<C-t>"] = {
          action = function()
            return "<cmd>ObsidianTemplate<CR>"
          end,
          opts = { noremap = true, expr = true, buffer = true },
        },
        ["gf"] = {
          action = function()
          return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
      },
      disable_frontmatter = true,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },  -- Load on file open
    config = treesitter_config,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", --[["hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline"]]},
  },

})
local cmp_plugin = require'cmp'
vim.g.rooter_patterns = {'.git', 'Makefile', '*.sln'}





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
-- vim.opt.switchbuf      = 'vsplit'





------------ Custom_switchbuf_on_quickfixlist -----------
-- Custom switchbuf behavior: useopen + vsplit hybrid
-- this is all AI generated and used for quickfix navigation
local function qf_navigate_hybrid(direction)
  local qf_list = vim.fn.getqflist()
  if #qf_list == 0 then return end

  local current_idx = vim.fn.getqflist({idx = 0}).idx
  local target_idx

  if direction == "next" then
    target_idx = current_idx < #qf_list and current_idx + 1 or 1
  elseif direction == "prev" then
    target_idx = current_idx > 1 and current_idx - 1 or #qf_list
  elseif direction == "first" then
    target_idx = 1
  elseif direction == "last" then
    target_idx = #qf_list
  elseif type(direction) == "number" then
    target_idx = direction
  else
    return
  end

  local item = qf_list[target_idx]

  -- Get the target file path (handle both bufnr and filename)
  local target_path
  if item.bufnr ~= 0 then
    target_path = vim.api.nvim_buf_get_name(item.bufnr)
  else
    target_path = vim.fn.fnamemodify(item.filename or '', ':p')
  end

  if target_path == '' then return end

  -- Check if this file is already displayed in any window
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local win_buf = vim.api.nvim_win_get_buf(win)
    local win_path = vim.api.nvim_buf_get_name(win_buf)

    if win_path == target_path then
      -- File found in this window, jump to it
      vim.api.nvim_set_current_win(win)
      vim.api.nvim_win_set_cursor(win, {item.lnum, math.max(0, item.col - 1)})
      vim.cmd("normal! zz")
      vim.fn.setqflist({}, 'a', {idx = target_idx})
      return
    end
  end

  -- File not open in any window, find a normal window and vsplit
  local found_normal_win = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buftype = vim.bo[vim.api.nvim_win_get_buf(win)].buftype
    if vim.api.nvim_win_get_config(win).relative == '' and buftype == '' then
      vim.api.nvim_set_current_win(win)
      found_normal_win = true
      break
    end
  end

  if found_normal_win then
    vim.cmd("vsplit")
    -- Open the file
    if item.bufnr ~= 0 then
      vim.cmd(string.format("buffer %d", item.bufnr))
    else
      vim.cmd(string.format("edit %s", vim.fn.fnameescape(target_path)))
    end
    vim.api.nvim_win_set_cursor(0, {item.lnum, math.max(0, item.col - 1)})
    vim.cmd("normal! zz")
    vim.fn.setqflist({}, 'a', {idx = target_idx})
  end
end

-- Create custom commands
vim.api.nvim_create_user_command("Cnext", function() qf_navigate_hybrid("next") end, {})
vim.api.nvim_create_user_command("Cprev", function() qf_navigate_hybrid("prev") end, {})
vim.api.nvim_create_user_command("Cfirst", function() qf_navigate_hybrid("first") end, {})
vim.api.nvim_create_user_command("Clast", function() qf_navigate_hybrid("last") end, {})
vim.api.nvim_create_user_command("Cc", function(opts)
  qf_navigate_hybrid(tonumber(opts.args) or vim.fn.getqflist({idx = 0}).idx)
end, {nargs = "?"})

-- Override <CR> in quickfix window
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", function()
      local idx = vim.fn.line('.')
      qf_navigate_hybrid(idx)
    end, { buffer = true, desc = "Open quickfix entry with hybrid behavior" })
  end,
})






-------------- Key_Maps -------------

vim.g.mapleader = " "

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
vim.api.nvim_create_user_command("Tab2", "set tabstop=2 shiftwidth=2 expandtab", {})
vim.api.nvim_create_user_command("Tab4", "set tabstop=4 shiftwidth=4 noexpandtab", {})
vim.api.nvim_set_keymap('n', "<C-t>", ":tabe | term<CR>:tabmove -1<CR>", {})
vim.api.nvim_set_keymap('v', '<leader>c', '', { desc = 'Copy file reference for Claude Code', callback = function()
  local start_line = vim.fn.line('v')  -- Start of visual selection
  local end_line = vim.fn.line('.')    -- Current cursor position
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local file_path = vim.fn.expand('%:.')
  local reference
  if start_line == end_line then
    reference = string.format("%s:%d", file_path, start_line)
  else
    reference = string.format("%s:%d-%d", file_path, start_line, end_line)
  end
  vim.fn.setreg('+', reference)
  print("Copied: " .. reference)
end })
vim.keymap.set('n', '<leader>c', function()
  local reference = string.format("%s:%d", vim.fn.expand('%:.'), vim.fn.line('.'))
  vim.fn.setreg('+', reference)
  print("Copied: " .. reference)
end, { desc = 'Copy current line reference for Claude Code' })
vim.api.nvim_set_keymap("t", "<S-CR>", "<CR>jkk", {})
vim.api.nvim_set_keymap("x", "C", "gc", {})
vim.keymap.set("n", "]q", function() qf_navigate_hybrid("next") end, {desc = "Next quickfix"})
vim.keymap.set("n", "[q", function() qf_navigate_hybrid("prev") end, {desc = "Prev quickfix"})

-- Plugin_mappings
vim.api.nvim_set_keymap("n", "<leader>fd", ":Telescope find_files<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<CR>", {})
vim.api.nvim_set_keymap('n', "<C-g>", ":0Gclog<CR>", {})
vim.api.nvim_set_keymap('n', "<Tab>", ":WintabsNext<CR>", {})
vim.api.nvim_set_keymap('n', "<S-Tab>", ":WintabsPrevious<CR>", {})
vim.api.nvim_set_keymap('n', "<leader>q", ":WintabsClose<CR>", {})

-- LSP_mappings
vim.api.nvim_set_keymap("n", "K",         "<cmd>lua vim.lsp.buf.hover()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
vim.api.nvim_set_keymap("n", "gD",        "<cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gd",        ":vsp<CR><cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gw",        ":sp<CR><C-w><C-k><cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gs",        "<cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gx",        ":sp<CR><cmd>lua vim.lsp.buf.definition()<CR>", {})
vim.api.nvim_set_keymap("n", "gi",        "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
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
--  ['<Tab>']     = cmp_plugin.mapping.confirm({ select = true }),
  ['<CR>']      = cmp_plugin.mapping.confirm({ select = false }),
}





------------ Legacy_stuff -----------

local init_path = vim.fn.stdpath('config')

vim.cmd([[

" Highlight whitespaces at end of line
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Configure timoutlen for jk in non-normal modes
au InsertEnter * set timeoutlen=170
au InsertLeave * set timeoutlen=1000
nnoremap <silent> <script> v :set timeoutlen=100<CR>v
nnoremap <silent> <script> V :set timeoutlen=100<CR>V
nnoremap <silent> <script> <C-v> :set timeoutlen=100<CR><C-v>

" Use matchit plugin to fold #region statements
packadd! matchit
au BufWinEnter * let b:match_words = '\s*#\s*region.*$:\s*#\s*endregion'

" Startify
let g:startify_custom_header = startify#fortune#boxed()
let g:startify_lists = [
	\ { 'type': 'sessions',  'header': ['	Sessoes Salvas'] },
	\ { 'type': 'files', 	 'header': ['	Arquivos Recentes'] },
	\ { 'type': 'bookmarks', 'header': ['	Bookmarks'] }
\ ]
"let g:startify_fortune_use_unicode = 1
let g:startify_bookmarks = [
  \ { 'i': ']] .. init_path .. [[/init.lua' },
\ ]

" Signify
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" Minimalist coloscheme adjusts
hi String         ctermfg=1                            guifg=#D6BF9C
hi Type           ctermfg=28                           guifg=#AFD787
hi Identifier                            cterm=NONE                             gui=NONE
hi Search                   ctermbg=8    cterm=NONE               guibg=#444444 gui=NONE
hi MatchParen               ctermbg=8    cterm=NONE               guibg=#444444 gui=NONE
hi StorageClass ctermfg=140 ctermbg=NONE cterm=NONE guifg=#AF87D7 guibg=NONE    gui=NONE
]])





------ Completion_and_builtin_LSPs ------

-- Mason LSP Installer
require('mason').setup()
require('mason-lspconfig').setup({
	automatic_enable = { exclude = { "omnisharp-mono" } },
})

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
vim.lsp.config('vue-language-server', {
  cmd = {data_path .. '\\mason\\packages\\vue-language-server\\node_modules\\.bin\\vue-language-server.cmd', '--stdio'},
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  init_options = { typescript = { tsdk = data_path .. '/mason/packages/vue-language-server/node_modules/typescript/lib' } },
  capabilities = cmp_capabilities
})

-- Omnisharp
vim.lsp.config('omnisharp', {
  on_error = function(code, err)
    return
    --local client_errors = require('vim.lsp.rpc').client_errors
    --if code == client_errors.INVALID_SERVER_JSON then
    --  return
    --else
    --  error(err)
    --end
  end,
  settings = {
    MsBuild = {
      -- If true, MSBuild project system will only load projects for files that
      -- were opened in the editor. This setting is useful for big C# codebases
      -- and allows for faster initialization of code navigation features only
      -- for projects that are relevant to code that is being edited. With this
      -- setting enabled OmniSharp may load fewer projects and may thus display
      -- incomplete reference lists for symbols.
      LoadProjectsOnDemand = true,
    },
    RoslynExtensionsOptions = {
      -- Enables support for showing unimported types and unimported extension
      -- methods in completion lists. When committed, the appropriate using
      -- directive will be added at the top of the current file. This option can
      -- have a negative impact on initial completion responsiveness,
      -- particularly for the first few completion sessions after opening a
      -- solution.
      EnableImportCompletion = nil,
      -- Enables the possibility to see the code in external nuget dependencies
      EnableDecompilationSupport = nil,
    },
    Sdk = {
      -- Specifies whether to include preview versions of the .NET SDK when
      -- determining which version to use for project loading.
      IncludePrereleases = false,
    },
  },
  capabilities = cmp_capabilities,
})

-- Clangd
vim.lsp.config('clangd', {
  capabilities = cmp_capabilities,
})

-- Zig
if windows then
	zig_cmd = '\\mason\\bin\\zls.cmd'
else
	zig_cmd = '/mason/bin/zls'
end
vim.lsp.config('zls', {
  cmd = { data_path .. zig_cmd },
  capabilities = cmp_capabilities,
  enableBuildOnSave = true,
  init_options = { zig_lib_path = vim.fn.expand('~/.version-fox/cache/zig/v-0.15.2/zig-0.15.2/lib/') },
})

vim.lsp.config('tsserver', {
  init_options = {
    maxTsServerMemory = 4096, -- MB
  },
})
