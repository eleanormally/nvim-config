local nmap = function(shortcut, command)
  vim.keymap.set('n', shortcut, command)
end

local map = function(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, {})
end

local navigator = require('Navigator')

------ quicklook vim files
nmap('<leader>vm', '<cmd>e ~/.config/nvim/lua/config/mapping.lua<cr>')
nmap('<leader>vs', '<cmd>e ~/.config/nvim/lua/config/settings.lua<cr>')
nmap('<leader>vv', '<cmd>e ~/.config/nvim/lua/config/visuals.lua<cr>')
nmap('<leader>vl', '<cmd>e ~/.config/nvim/lua/config/lsp.lua<cr>')


------ file navigation
-- open mini files in current file directory (if file doesn't exist open cwd)
local MiniFiles = require('mini.files')
nmap('<leader>e', function()
  local name = vim.api.nvim_buf_get_name(0)
  if vim.fn.filereadable(name) ~= 1 then
    MiniFiles.open(nil, false)
  else
    MiniFiles.open(name, false)
  end
end)

-- open mini files in cwd
nmap('<leader>E', function()
  MiniFiles.open(nil, false)
end)

-- open scratchpad
nmap('<leader>ss', '<cmd>e ~/scratchpad<cr>')
---- harpoon
local harpoon = require("harpoon")
harpoon:setup()
-- add current file to harpoon
nmap('<leader>hh', function()
  harpoon:list():append()
  vim.cmd('redrawtabline')
end)
nmap('<leader>hu', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
nmap('<leader>ha', function() harpoon:list():select(1) end)
nmap('<leader>hr', function() harpoon:list():select(2) end)
nmap('<leader>hs', function() harpoon:list():select(3) end)
nmap('<leader>ht', function() harpoon:list():select(4) end)

------ buffer navigation and manipulation
-- show undo tree
nmap('<leader>u', vim.cmd.UndotreeToggle)
-- clear all hidden windows
nmap('<leader>bc', function()
  require('close_buffers').delete({
    type = 'hidden',
    force = false,
  })
end)
-- close buffer
nmap('<leader>c', '<cmd>bd<cr>')
-- zen current split
nmap('<leader>bz', function()
  vim.cmd('execute "normal mt"')
  vim.cmd('tabnew %')
  vim.cmd('execute "normal gT"')
  vim.cmd('tabc')
  vim.cmd('execute "normal `t"')
  vim.cmd('delmarks t')
end)
-- vertical split
nmap('|', function()
  vim.cmd('vsplit')
  navigator.right()
end)
-- horitzontal split
nmap('\\', function()
  vim.cmd('split')
  navigator.down()
end)
-- display jump keys
nmap('<leader>j', require('nvim-window').pick)

local smartsplits = require('smart-splits')
---- move between buffers
nmap('<C-left>', smartsplits.resize_left)
nmap('<C-right>', smartsplits.resize_right)
nmap('<C-down>', smartsplits.resize_down)
nmap('<C-up>', smartsplits.resize_up)
nmap('<leader><up>', function()
  smartsplits.swap_buf_up()
  navigator.up()
end)
---- swap buffers
nmap('<leader><down>', function()
  smartsplits.swap_buf_down()
  navigator.down()
end)
nmap('<leader><left>', function()
  smartsplits.swap_buf_left()
  navigator.left()
end)
nmap('<leader><right>', function()
  smartsplits.swap_buf_right()
  navigator.right()
end)
---- terminal
-- display terminal
nmap('<leader>th', '<cmd>ToggleTerm<cr>')
-- allow for escape in terminal
map('t', '<Esc>', '<C-\\><C-n>')

------ current window navigation
-- make ' jump horizontally not just vertically
nmap('\'', '`')


------ text manipulation
-- whole file copy
nmap('<leader>y', 'mq1ggVGy\'q')
-- disable replay of last macro accidentally
nmap('Q', '<nop>')
-- shift arrows in vertical move selected
map('v', '<S-down>', ":m '>+1<CR>gv=gv")
map('v', '<S-up>', ":m '<-2<CR>gv=gv")
-- j and k pop and push newlines
map('n', 'j', 'mzJ`z')
map('n', 'k', 'i<cr><Esc>zz')
-- remove highlight on espace
map('n', '<Esc>', "<cmd>nohlsearch<CR>")
-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})



------ telescope
local telescope = require('telescope.builtin')
-- list buffers
nmap('<leader>fb', telescope.buffers)
-- list files
nmap('<leader>ff', telescope.find_files)
-- grep through all files
nmap('<leader>fw', telescope.live_grep)

------ lsp/code info
-- code actions. if no code actions exist in current word then do full line, then do full file
map({ 'n', 'v' }, '<leader>la', function()
  vim.cmd('Lspsaga code_action')
end)
-- go to definition
nmap('gd', vim.lsp.buf.definition)
-- float description of issue
map({ 'n', 'v' }, '<leader>ld', vim.diagnostic.open_float)
-- float information about the current symbol
nmap('<leader>lt', vim.lsp.buf.hover)
-- list document symbols
nmap('<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>')
nmap('<leader>sd', function()
  vim.cmd('vsplit')
  navigator.right()
  vim.cmd(':normal gd')
end)
nmap('gr', require('telescope.builtin').lsp_references)
nmap('gd', require('telescope.builtin').lsp_definitions)



------ neovim tooling
-- open treesitter playground
map('n', '<leader>tp', function()
  vim.cmd('TSPlaygroundToggle')
  navigator.left()
end)
