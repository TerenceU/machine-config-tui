-- Configurazione avanzata di Telescope
require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git/",
			"%.jpg",
			"%.jpeg",
			"%.png",
			"%.svg",
			"%.otf",
			"%.ttf",
		},
		-- Custom sorter per prioritizzare cartelle specifiche
		file_sorter = function()
			local conf = require('telescope.config').values
			local fzy_sorter = conf.file_sorter()
			
			-- Funzione che modifica lo score in base al path
			local original_scoring_function = fzy_sorter.scoring_function
			fzy_sorter.scoring_function = function(self, prompt, line, entry)
				local score = original_scoring_function(self, prompt, line, entry)
				
				-- Prioritizza .config e repos
				if string.match(line, "%.config/") then
					score = score - 10  -- Score più basso = priorità più alta
				elseif string.match(line, "repos/") then
					score = score - 8
				end
				
				return score
			end
			
			return fzy_sorter
		end,
	},
	pickers = {
		find_files = {
			hidden = true,  -- Mostra anche file nascosti (come .config)
			no_ignore = false,  -- Rispetta .gitignore
			-- Usa fd per ricerca più veloce e profonda
			find_command = { 'fd', '--type', 'f', '--hidden', '--follow', '--exclude', '.git' },
		},
	},
})

-- Carica estensioni
pcall(require('telescope').load_extension, 'fzf')
