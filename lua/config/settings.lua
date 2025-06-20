------ editor appearance
-- show number
vim.opt.number = true
-- relative number
vim.opt.relativenumber = true
-- disable text wrap
vim.opt.wrap = false
-- allow for smooth side scrolling
vim.opt.sidescroll = 1
-- add padding for reading long lines
vim.opt.sidescrolloff = 20
-- disable highlighting search
-- vim.cmd({ cmd = 'set', args = { 'nohlsearch' } })
-- line length column configuration
-- highlight match while typing
vim.opt.incsearch = true
-- ensure coloring
vim.opt.termguicolors = true
-- center cursor vertically
vim.opt.scrolloff = 999
-- always show the sign column (displays error warnings and marks)
vim.opt.signcolumn = 'yes'
------ tab settings
-- tab in file display length
vim.opt.tabstop = 2
-- tab to space conversion when editing
vim.opt.softtabstop = 2
-- space count for auto indent
vim.opt.shiftwidth = 2
-- replace tab with space when typing tab key
vim.opt.expandtab = true
-- autoindent for c (disabled because treesitter should cover this)
-- vim.opt.smartindent = true
vim.cmd('let &colorcolumn=join(range(81,999),",")')


------ editor functionality
-- swapfiles
vim.opt.swapfile = false
-- disable creating backup file on overwrite
vim.opt.backup = false
-- specify a directory for undotree to persist in
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
-- enable undo storage
vim.opt.undofile = true
-- add - to filenames. not sure why I had this before, so its staying commented out
-- vim.opt.isfname:append('@-@')
-- flush swap file after this much time
-- vim.opt.updatetime = 50
-- timeout command after a second
vim.opt.timeoutlen = 1000


------ language settings (potentially should be moved to lsp config)
vim.filetype.add({ extension = { templ = "templ" } })
