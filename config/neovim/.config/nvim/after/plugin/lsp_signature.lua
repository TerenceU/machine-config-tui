-- Mostra automaticamente i parametri delle funzioni mentre scrivi
require('lsp_signature').setup({
	bind = true,
	hint_enable = false,
	handler_opts = {
		border = "rounded"
	},
	floating_window = true,
	toggle_key = '<C-k>',
})
