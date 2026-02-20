-- Sticky context come VS Code (mostra la funzione/classe corrente in cima)
require('treesitter-context').setup({
	enable = true,
	multiwindow = false,
	max_lines = 0,           -- 0 = nessun limite
	min_window_height = 0,   -- 0 = sempre attivo
	line_numbers = true,
	multiline_threshold = 20,
	trim_scope = 'outer',
	mode = 'cursor',
	separator = nil,         -- nil per evitare il requisito di 2 righe sopra
	zindex = 20,
})

-- Toggle sticky context con <leader>tc
vim.keymap.set('n', '<leader>tc', function()
	require('treesitter-context').toggle()
end, { desc = "Toggle sticky context" })

-- Salta al contesto con [C
vim.keymap.set('n', '[C', function()
	require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true, desc = "Jump to context" })

