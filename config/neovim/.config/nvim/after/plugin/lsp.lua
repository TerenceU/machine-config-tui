-- Setup Mason per installare automaticamente i language servers
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",        -- TypeScript/JavaScript
		"rust_analyzer", -- Rust
		"gopls",         -- Go
		"html",          -- HTML
		"cssls",         -- CSS
		"omnisharp",     -- C# .NET
		"lua_ls",
		"pylsp"
	},
	automatic_installation = true,
})

-- Configurazione diagnostici (mostra i messaggi di errore)
vim.diagnostic.config({
	float = {
		source = true,  -- Mostra la fonte nel popup
		border = 'rounded',
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Simboli per i diagnostici
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Mostra automaticamente il popup con l'errore quando il cursore si ferma
-- Usa un timer personalizzato invece di CursorHold per controllo indipendente
local timer = nil
vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function()
		if timer then
			vim.fn.timer_stop(timer)
		end
		timer = vim.fn.timer_start(500, function()  -- 500ms personalizzabile
			vim.diagnostic.open_float(nil, {
				focusable = false
			})
		end)
	end
})

-- Keybindings quando LSP è attivo
local opt = { buffer = bufnr, remap = false }

vim.keymap.set("n", "gd", vim.lsp.buf.definition, opt)
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.hover, opt)
vim.keymap.set("n", "<leader>lws", vim.lsp.buf.workspace_symbol, opt)
vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opt)
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opt)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opt)

-- Lista di server con le loro configurazioni
-- Configurazione server LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = {
	{
		name = 'lua_ls',
		settings = {
			Lua = {
				runtime = { version = 'LuaJIT' },
				diagnostics = {
					globals = { 'vim', 'bufnr' },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = { enable = false },
			},
		},
	},
	{ name = 'ts_ls', settings = {} },
	{ name = 'rust_analyzer', settings = {} },
	{ name = 'gopls', settings = {} },
	{ name = 'html', settings = {} },
	{ name = 'cssls', settings = {} },
	{ name = 'omnisharp', settings = {} },
	{ name = 'pylsp', settings = {} },
}

-- Configura ed abilita tutti i server
for _, server in ipairs(servers) do
	vim.lsp.config[server.name] = {
		settings = server.settings,
		capabilities = capabilities,
	}
	vim.lsp.enable(server.name)
end

