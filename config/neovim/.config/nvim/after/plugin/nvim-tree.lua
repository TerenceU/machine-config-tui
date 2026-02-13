-- Disabilita netrw (file explorer integrato)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Funzione per keybindings custom
local function my_on_attach(bufnr)
	local api = require('nvim-tree.api')
	
	-- Usa i default
	api.config.mappings.default_on_attach(bufnr)
	
	-- Aggiungi/modifica keybindings
	local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
	vim.keymap.set('n', 'y', api.fs.copy.node, opts)  -- copia con 'y'
end

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
	actions = {
		open_file = {
			quit_on_open = true,  -- Chiude nvim-tree quando apri un file
		},
	},
	on_attach = my_on_attach,
})

-- Keybindings
vim.keymap.set('n', '<leader><leader>', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFile<CR>', { desc = 'Find current file in tree' })

-- NOTA: All'interno di nvim-tree usa:
-- 'a' = crea file/cartella
--   - "path/to/file.txt" crea cartelle + file
--   - "path/to/folder/" crea solo cartelle ricorsive
-- 'y' = copia
-- 'd' = elimina
-- 'r' = rinomina
-- 'x' = taglia
-- 'p' = incolla
-- 'R' = ricarica
-- '?' = mostra tutti i comandi

