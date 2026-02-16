vim.g.mapleader = " "
-- Rimosso <leader><leader> per usarlo con nvim-tree

-- Buffer management
vim.keymap.set("n", "<leader>ww", ":wa<CR>", { desc = "Save all buffers" })
vim.keymap.set("n", "<leader>qq", ":qa<CR>", { desc = "Quit all (asks for unsaved)" })
vim.keymap.set("n", "<leader>qw", ":wqa<CR>", { desc = "Save and quit all" })
vim.keymap.set("n", "<leader>qf", ":qa!<CR>", { desc = "Force quit all (no save)" })

-- Clipboard (system) - leader c
vim.keymap.set({"n", "v"}, "<leader>cy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>cY", '"+Y', { desc = "Copy line to system clipboard" })
vim.keymap.set({"n", "v"}, "<leader>cp", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({"n", "v"}, "<leader>cP", '"+P', { desc = "Paste before from system clipboard" })

-- Window navigation con Ctrl+hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window splits
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Split horizontally" })

-- Goto line
vim.keymap.set("n", "gl", function()
	local line = vim.fn.input("Go to line: ")
	if line ~= "" then
		vim.cmd(line)
	end
end, { desc = "Go to line number" })
