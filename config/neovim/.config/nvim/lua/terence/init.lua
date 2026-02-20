require("terence.colorschema")
require("terence.packer")
require("terence.remap")

-- Numeri di riga relativi
vim.opt.number = true          -- Mostra numero riga corrente
vim.opt.relativenumber = true  -- Numeri relativi per le altre righe

-- Scroll automatico quando vicino ai bordi
vim.opt.scrolloff = 10         -- Inizia a scrollare quando sei a 10 righe dal bordo
vim.opt.sidescrolloff = 8      -- Stesso concetto ma orizzontale (8 colonne)

-- Disabilita word wrap
vim.opt.wrap = false           -- Righe lunghe non vanno a capo

-- Indentazione
vim.opt.tabstop = 4            -- Tab = 4 spazi
vim.opt.shiftwidth = 4         -- Indentazione automatica = 4 spazi
vim.opt.softtabstop = 4        -- Tab in insert mode = 4 spazi
vim.opt.expandtab = true       -- Usa spazi invece di tab
vim.opt.smartindent = true     -- Indentazione intelligente

-- Ricerca case insensitive
vim.opt.ignorecase = true      -- Ignora maiuscole/minuscole nella ricerca
vim.opt.smartcase = true       -- Se scrivi maiuscole, diventa case sensitive
vim.opt.wildignorecase = true  -- Case insensitive anche per completamento comandi

-- Auto-change directory quando apri una cartella
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			vim.cmd("cd " .. vim.fn.fnameescape(arg))
			print("Changed directory to: " .. arg)
		end
	end
})
