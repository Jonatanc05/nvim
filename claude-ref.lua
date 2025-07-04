-- Simple plugin to copy file references for Claude Code
-- Made by Claude

local M = {}

-- Function to copy current selection as file reference
function M.copy_reference()
  -- Get current buffer info
  local file_path = vim.fn.expand('%:.')  -- Relative path from cwd

  -- Get visual selection range
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Format the reference
  local reference
  if start_line == end_line then
    reference = string.format("%s:%d", file_path, start_line)
  else
    reference = string.format("%s:%d-%d", file_path, start_line, end_line)
  end

  -- Copy to system clipboard
  vim.fn.setreg('+', reference)

  -- Show confirmation
  print("Copied: " .. reference)
end

-- Setup function to create keybindings
function M.setup(opts)
  opts = opts or {}
  local keymap = opts.keymap or '<leader>c'

  -- Create visual mode mapping
  vim.keymap.set('v', keymap, M.copy_reference, { desc = 'Copy file reference for Claude Code' })

  -- Also support normal mode for current line
  vim.keymap.set('n', keymap, function()
    local line = vim.fn.line('.')
    local file_path = vim.fn.expand('%:.')
    local reference = string.format("%s:%d", file_path, line)
    vim.fn.setreg('+', reference)
    print("Copied: " .. reference)
  end, { desc = 'Copy current line reference for Claude Code' })
end

return M
