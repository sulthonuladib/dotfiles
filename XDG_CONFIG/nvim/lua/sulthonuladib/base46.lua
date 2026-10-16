-- NvChad base46 theming.
--
-- base46 compiles the highlight groups of the theme in `lua/chadrc.lua` into
-- Lua cache files under `vim.g.base46_cache`, then we load them. This gives us
-- the NvChad look for the completion popup (BlinkCmp*), signature help,
-- floating windows, diagnostics, etc., without pulling in NvChad's statusline
-- or tabufline.
--
-- To switch themes: change `base46.theme` in `lua/chadrc.lua` and restart (the
-- cache is rebuilt automatically when chadrc.lua is newer than it), or run
-- `:lua require("base46").load_all_highlights()`.
local M = {}

local function cache_exists()
	local cache = vim.g.base46_cache
	return cache ~= nil and vim.uv.fs_stat(cache) ~= nil
end

-- Recompile when chadrc.lua is newer than the compiled cache, so theme /
-- hl_override edits are picked up without a manual `load_all_highlights()`.
local function cache_stale()
	local cache_file = vim.uv.fs_stat(vim.g.base46_cache .. "defaults")
	if not cache_file then
		return true
	end

	local chadrc = vim.uv.fs_stat(vim.fn.stdpath("config") .. "/lua/chadrc.lua")
	return chadrc ~= nil and chadrc.mtime.sec > cache_file.mtime.sec
end

function M.setup()
	-- First run, or the theme config changed: compile + load.
	if not cache_exists() or cache_stale() then
		require("base46").load_all_highlights()
		return
	end

	-- Fast path: just load the already-compiled caches.
	for _, file in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
		dofile(vim.g.base46_cache .. file)
	end
end

M.setup()

return M
