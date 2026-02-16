-- Configurazione Markdown Preview
vim.g.mkdp_auto_start = 0  -- Non apre automaticamente
vim.g.mkdp_auto_close = 1  -- Chiude quando esci dal buffer
vim.g.mkdp_refresh_slow = 0  -- Refresh in tempo reale
vim.g.mkdp_browser = 'qutebrowser'  -- Usa qutebrowser per preview
vim.g.mkdp_theme = 'dark'  -- Tema scuro

-- Funzione per gestire preview di diversi tipi di file
local function preview_file()
	local filetype = vim.bo.filetype
	
	if filetype == "markdown" then
		vim.cmd("MarkdownPreviewToggle")
	elseif filetype == "html" then
		-- Apri file HTML in qutebrowser
		local filepath = vim.fn.expand("%:p")
		vim.fn.system("qutebrowser '" .. filepath .. "' &")
		vim.notify("Opening HTML in qutebrowser", vim.log.levels.INFO)
	else
		vim.notify("Preview not available for " .. filetype, vim.log.levels.WARN)
	end
end

-- Keybinding per markdown e HTML
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "html" },
	callback = function()
		vim.keymap.set('n', '<leader>p', preview_file, { buffer = true, silent = true, desc = "Preview file" })
	end
})

-- NOTA: 
-- Markdown: <leader>p = toggle preview
-- HTML: <leader>p = apre in qutebrowser

