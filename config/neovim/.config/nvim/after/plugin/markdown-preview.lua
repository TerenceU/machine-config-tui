-- Configurazione Markdown Preview
vim.g.mkdp_auto_start = 0  -- Non apre automaticamente
vim.g.mkdp_auto_close = 1  -- Chiude quando esci dal buffer
vim.g.mkdp_refresh_slow = 0  -- Refresh in tempo reale
vim.g.mkdp_browser = 'qutebrowser'  -- Usa qutebrowser per preview
vim.g.mkdp_theme = 'dark'  -- Tema scuro

-- Keybindings (solo per file markdown)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		local opts = { buffer = true, silent = true }
		vim.keymap.set('n', '<leader>p', ':MarkdownPreviewToggle<CR>', opts)
	end
})

-- NOTA: Apri un file .md e usa:
-- <leader>mp = apre preview nel browser
-- <leader>ms = chiude preview
-- <leader>mt = toggle preview
