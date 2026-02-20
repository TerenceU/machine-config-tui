-- Configurazione Gitsigns per gestire modifiche git
require('gitsigns').setup({
	signs = {
		add          = { text = '│' },
		change       = { text = '│' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	signcolumn = true,  -- Mostra segni nella colonna
	numhl      = false, -- Highlight numero riga
	linehl     = false, -- Highlight intera riga
	word_diff  = false, -- Word diff inline
	watch_gitdir = {
		follow_files = true
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Mostra blame sulla riga corrente
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol',
		delay = 1000,
		ignore_whitespace = false,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil,
	max_file_length = 40000,
	preview_config = {
		border = 'rounded',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end
		
		-- Navigation tra hunks (modifiche)
		map('n', ']c', function()
			if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, {expr=true, desc="Next git hunk"})
		
		map('n', '[c', function()
			if vim.wo.diff then return '[c' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, {expr=true, desc="Previous git hunk"})
		
		-- Actions con <leader>g (git)
		map('n', '<leader>gs', gs.stage_hunk, {desc="Stage hunk"})
		map('n', '<leader>gr', gs.reset_hunk, {desc="Reset hunk"})
		map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc="Stage hunk"})
		map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc="Reset hunk"})
		map('n', '<leader>gS', gs.stage_buffer, {desc="Stage buffer"})
		map('n', '<leader>gu', gs.undo_stage_hunk, {desc="Undo stage hunk"})
		map('n', '<leader>gR', gs.reset_buffer, {desc="Reset buffer"})
		map('n', '<leader>gp', gs.preview_hunk, {desc="Preview hunk"})
		map('n', '<leader>gb', function() gs.blame_line{full=true} end, {desc="Blame line"})
		map('n', '<leader>gtb', gs.toggle_current_line_blame, {desc="Toggle line blame"})
		map('n', '<leader>gd', gs.diffthis, {desc="Diff this"})
		map('n', '<leader>gD', function() gs.diffthis('~') end, {desc="Diff this ~"})
		map('n', '<leader>gtd', gs.toggle_deleted, {desc="Toggle deleted"})
		
		-- Text object per hunks
		map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc="Select hunk"})
	end
})

-- Comandi Git aggiuntivi (commit, push, pull)
vim.keymap.set('n', '<leader>gc', function()
	local msg = vim.fn.input("Commit message: ")
	if msg ~= "" then
		vim.cmd("!git add -A && git commit -m '" .. msg .. "'")
	end
end, { desc = "Git commit all" })

vim.keymap.set('n', '<leader>gP', ':!git push<CR>', { desc = "Git push" })
vim.keymap.set('n', '<leader>gPt', ':!git push --tags<CR>', { desc = "Git push tags" })
vim.keymap.set('n', '<leader>gp', ':!git pull<CR>', { desc = "Git pull" })
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = "Open LazyGit" })

vim.keymap.set('n', '<leader>gt', function()
	local tag = vim.fn.input("Tag name: ")
	if tag == "" then return end
	local msg = vim.fn.input("Tag message (leave empty for lightweight tag): ")
	if msg ~= "" then
		vim.cmd("!git tag -a " .. tag .. " -m '" .. msg .. "'")
	else
		vim.cmd("!git tag " .. tag)
	end
	local push = vim.fn.confirm("Push tag '" .. tag .. "' to remote?", "&Yes\n&No", 2)
	if push == 1 then
		vim.cmd("!git push origin " .. tag)
	end
end, { desc = "Git create tag" })
