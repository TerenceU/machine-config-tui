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
