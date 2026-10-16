local add_keymap = vim.keymap.set

-- local actions = require("telescope.actions")
require("telescope").setup({
	--  All the info you're looking for is in `:help telescope.setup()`
	-- you can put your default mappings / updates / etc. in here
	--
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
				["<C-n>"] = "cycle_history_next",
				["<C-p>"] = "cycle_history_prev",
			},
		},
	},
	pickers = {
		find_files = {
			-- `rg` respects .gitignore by default, so --hidden shows dotfiles
			-- without showing gitignored files. Exclude .git/ itself explicitly.
			-- Later globs win. The leading '*' whitelist is required: without it,
			-- the non-negated config.toml glob would whitelist ONLY that file.
			find_command = {
				"rg",
				"--files",
				"--hidden",
				"--glob",
				"*",
				"--glob",
				"!**/.git/*",
				"--glob",
				"!**/herdr/**",
				"--glob",
				"**/herdr/config.toml",
			},
		},
		live_grep = {
			additional_args = {
				"--hidden",
				"--glob",
				"*",
				"--glob",
				"!**/.git/*",
				"--glob",
				"!**/herdr/**",
				"--glob",
				"**/herdr/config.toml",
			},
		},
	},
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
	},
})

-- Enable Telescope extensions if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Search Help" })
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Search by Grep" })

-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
-- If you later switch picker plugins, this is where to update these mappings.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf

		-- Find references for the word under your cursor.
		add_keymap("n", "<leader>gr", builtin.lsp_references, { buffer = buf, desc = "Goto references" })
		add_keymap("n", "<leader>gd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })
		add_keymap("n", "gd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })
	end,
})

-- Override default behavior and theme when searching
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
