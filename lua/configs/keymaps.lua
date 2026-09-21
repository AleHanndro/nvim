local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move end of line" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<C-q>", function() Snacks.bufdelete.delete() end, { desc = "Delete buffer" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Find
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find files" })
-- Search
map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Search Buffer Lines" })
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Search Open Buffers" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Search Workspace" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Search Help Pages" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Search Keymaps" })
map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Search visual selection or word" })

-- Explorer
map("n", "<C-n>", function() Snacks.picker.explorer() end, { desc = "File Explorer" })

-- vim: ts=2 sts=2 sw=2 et
