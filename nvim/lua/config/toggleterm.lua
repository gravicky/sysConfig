-- Set up ToggleTerm with default configuration
require("toggleterm").setup({
  -- Optional configuration options for toggleterm.nvim can go here

  -- Key mappings
  open_mapping = [[<c-t>]],  -- Use Ctrl-t to open/close the terminal
  start_in_insert = true,    -- Start in insert mode by default
  insert_mappings = true,   -- Apply mappings in insert mode
  terminal_mappings = true, -- Apply mappings inside the terminal

  -- Behavior on opening and closing terminals
  on_open = function(term)
    vim.cmd("startinsert!") -- Enter insert mode when the terminal opens
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  on_close = function(term)
    vim.cmd("startinsert!") -- Return to insert mode when the terminal closes
  end,

  -- Misc options
  close_on_exit = false,      -- Do not close the terminal when the process exits
  auto_scroll = true,        -- Scroll automatically to the bottom of terminal output
  shade_terminals = true,    -- Shade terminal windows
  shading_factor = 2,        -- Factor to shade the terminal
  shade_filetypes = {},

})

-- Function to set terminal keymaps
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts) -- exit terminal mode on esc
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts) -- exit terminal mode on jk
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts) -- move to left terminal window
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts) -- move to terminal window below
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts) -- move to terminal window above
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts) -- move to right terminal window
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts) -- enter window command mode
end

-- Set up an autocmd to apply keymaps when opening a terminal
vim.cmd('autocmd TermOpen * lua set_terminal_keymaps()')

-- Import the Terminal class from toggleterm
local Terminal = require('toggleterm.terminal').Terminal

-- Configure LazyGit terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double", -- Border style for floating terminal
  },
  -- Function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- Function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

-- Define a function to toggle LazyGit terminal visibility
function _lazygit_toggle()
  lazygit:toggle()
end

-- Map <leader>g to toggle LazyGit terminal
vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

