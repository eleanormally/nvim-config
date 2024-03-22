map = function(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, {})
end


local navigator = require('Navigator')
-- vim config

map('n', '<leader>vm', '<cmd>e ~/.config/nvim/lua/config/mappings.lua<cr>')
map('n', '<leader>vs', '<cmd>e ~/.config/nvim/lua/config/set.lua<cr>')
map('n', '<leader>vl', '<cmd>e ~/.config/nvim/lua/config/lsp.lua<cr>')
map('n', '<leader>vc', '<cmd>e ~/.config/nvim/lua/plugins/custom.lua<cr>')
map('n', '<leader>vps', '<cmd>e ~/.config/nvim/lua/plugins/simples.lua<cr>')
map('n', '<leader>vpc', '<cmd>e ~/.config/nvim/lua/plugins/custom.lua<cr>')
map('n', '<leader>vpm', '<cmd>e ~/.config/nvim/lua/plugins/mini.lua<cr>')
map('n', '<leader>vpt', '<cmd>e ~/.config/nvim/lua/plugins/treesitter.lua<cr>')


-- scratch
map('n', '<leader>ss', '<cmd>e ~/scratchpad<cr>')

-- treesitter
map('n', '<leader>tp', function()
  vim.cmd('TSPlaygroundToggle')
  navigator.left()
end)


local MiniFiles = require('mini.files')
map('n', '<leader>e', function()
  local name = vim.api.nvim_buf_get_name(0)
  MiniFiles.open(name)

  if name ~= '' then
    local depth = -2
    local _, init = name:find(vim.pesc(vim.loop.cwd()))
    while init do
      depth = depth + 1
      init = name:find('/', init + 1)
    end

    for _ = 1, depth do MiniFiles.go_out() end
    for _ = 1, depth do MiniFiles.go_in() end
    MiniFiles.trim_left()
  end
end)

map('n', '<leader>ps', '<cmd>Lazy sync<cr>')

map('n', '<leader>y', "mq1ggVGy'q")

-- telescope
local builtin = require('telescope.builtin')
map('n', '<leader>fb', builtin.buffers)
map('n', '<leader>ff', builtin.find_files)
map('n', '<leader>fw', builtin.live_grep)

-- lsp
map('n', '<leader>la', vim.lsp.buf.code_action)
map('n', '<leader>ld', vim.diagnostic.open_float)
map('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>')
map('n', '<leader>lt', vim.lsp.buf.hover)

map('n', '<leader>sd', function()
  vim.cmd('vsplit')
  navigator.right()
  vim.cmd(':normal gd')
end)


-- harpoon
local harpoon = require("harpoon")
harpoon:setup({
  global_settings = {
    tabline = true

  }
})

map('n', '<leader>hh', function()
  harpoon:list():append()
  vim.cmd('redrawtabline')
end
)
map('n', '<leader>hu', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
map('n', '<leader>ha', function() harpoon:list():select(1) end)
map('n', '<leader>hr', function() harpoon:list():select(2) end)
map('n', '<leader>hs', function() harpoon:list():select(3) end)
map('n', '<leader>ht', function() harpoon:list():select(4) end)

-- nav
map({ 'n', 'i' }, '<down>', '<down><cmd>normal zz<cr>')
map({ 'n', 'i' }, '<up>', '<up><cmd>normal zz<cr>')
map({ 'n' }, '+', "+zz")
map({ 'n' }, '-', "-zz")
map('n', 'gg', 'ggzz')

map('n', '<leader>u', vim.cmd.UndotreeToggle)

map('n', '\'', '`')

-- text manipulation
map('v', '<S-down>', ":m '>+1<CR>gv=gv")
map('v', '<S-up>', ":m '<-2<CR>gv=gv")
map('n', 'j', 'mzJ`z')
map('n', 'k', 'i<cr><Esc>zz')

-- commenting
-- map('n', '<leader>/', ':normal gcc<cr>')
-- map('v', '<leader>/', ':normal gcc<cr>')

-- cursor movement
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('n', 'Q', '<nop>')
map('n', '<C-q>', 'q')
map('n', 'q', '<nop>')

-- windows and window nav

map('n', '<leader>bc', "<C-w>o")
map('n', '<leader>c', "<cmd>bd<cr>")

map('n', '|', function()
  vim.cmd('vsplit')
  navigator.right()
end
)
map('n', '\\', function()
  vim.cmd('split')
  navigator.down()
end)
map('n', '<leader>j', require('nvim-window').pick)

local smartsplits = require('smart-splits')
map('n', '<C-left>', smartsplits.resize_left)
map('n', '<C-right>', smartsplits.resize_right)
map('n', '<C-down>', smartsplits.resize_down)
map('n', '<C-up>', smartsplits.resize_up)
map('n', '<leader><up>', function()
  smartsplits.swap_buf_up()
  navigator.up()
end)
map('n', '<leader><down>', function()
  smartsplits.swap_buf_down()
  navigator.down()
end)
map('n', '<leader><left>', function()
  smartsplits.swap_buf_left()
  navigator.left()
end)
map('n', '<leader><right>', function()
  smartsplits.swap_buf_right()
  navigator.right()
end)

map('n', '<leader>bc', function() require('close_buffers').delete({ type = 'hidden', force = false }) end)
map('n', '<leader>bz', "mt<cmd>tabnew %<cr> | gT | <cmd>tabc<cr> | 't | dmt")


-- copilot
local copilot = require('copilot.suggestion')

map('i', '<S-enter>', function()
  if copilot.is_visible() then
    copilot.accept()
  end
end)
map('i', '<C-enter>', function()
  copilot.next()
end)
map('i', '<CS-enter>', function()
  if copilot.is_visible() then
    copilot.prev()
  end
end)


-- terminal
map('t', '<Esc>', '<C-\\><C-n>')
map('n', '<leader>th', '<cmd>ToggleTerm<cr>')


-- mark navigation
