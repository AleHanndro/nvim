local opt = vim.opt

vim.loader.enable()

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false
opt.laststatus = 3 -- global statusline
opt.list = true
opt.ruler = false
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2

-- indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.schedule(function() opt.clipboard = "unnamedplus" end)

opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 250
opt.timeoutlen = 400

opt.signcolumn = "yes"
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true
opt.cursorline = true

opt.inccommand = "split" -- preview substitutions live
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.confirm = true

-- vim: ts=2 sts=2 sw=2 et
