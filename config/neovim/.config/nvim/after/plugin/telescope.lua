local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>fb', function()
	builtin.buffers({ initial_mode = "normal" })
end, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader><Tab>', function()
	builtin.buffers({ initial_mode = "normal" })
end, { desc = 'Quick buffer switch' })
vim.keymap.set('n', '<leader>fG', builtin.live_grep, { desc = 'Telescope live grep' })

