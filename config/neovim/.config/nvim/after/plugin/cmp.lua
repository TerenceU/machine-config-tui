-- Configurazione autocompletion
local cmp = require('cmp')
local luasnip = require('luasnip')

-- Setup copilot-cmp se disponibile
local copilot_cmp_ok, copilot_cmp = pcall(require, "copilot_cmp")
if copilot_cmp_ok then
	copilot_cmp.setup()
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		documentation = cmp.config.window.bordered(),
		completion = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = false }), -- Enter conferma solo se hai selezionato
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })  -- Tab conferma sempre, anche senza selezione
			else
				fallback()  -- Se non c'è menu, comportamento normale di Tab
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = "copilot", group_index = 2 },  -- Copilot suggerimenti
		{ name = 'nvim_lsp', group_index = 2 },
		{ name = 'luasnip', group_index = 2 },
	}, {
		{ name = 'buffer' },
		{ name = 'path' },
	}),
	-- Icone per distinguere le fonti
	formatting = {
		format = function(entry, vim_item)
			-- Aggiungi icona per Copilot
			if entry.source.name == "copilot" then
				vim_item.kind = " Copilot"
				vim_item.kind_hl_group = "CmpItemKindCopilot"
			end
			return vim_item
		end
	},
})

-- Highlight per Copilot
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
