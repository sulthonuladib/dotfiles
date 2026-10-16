-- vim.pack helper commands

vim.api.nvim_create_user_command("PackAdd", function(opts)
	vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (PackAdd user/repo)" })

vim.api.nvim_create_user_command("PackDel", function(opts)
	vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel plugin1 plugin2)" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
	if opts.args ~= "" then
		-- update specific plugins
		local plugins = vim.split(opts.args, "%s+", { trimempty = true })
		vim.pack.update(plugins)
	else
		-- update all
		vim.pack.update()
	end
end, { desc = "Update all plugins or specific ones", nargs = "*" })

-- show all non-active plugins on disk but removed from pack.lua
vim.api.nvim_create_user_command("PackCheck", function()
	local non_active = vim.iter(vim.pack.get())
		:filter(function(x)
			return not x.active
		end)
		:map(function(x)
			return x.spec.name
		end)
		:totable()

	if #non_active == 0 then
		vim.notify("No non-active plugins found!", vim.log.levels.INFO)
		return
	end

	vim.print("Non-active plugins:")
	for _, name in ipairs(non_active) do
		print(name)
	end

	local choice = vim.fn.confirm("Delete ALL non-active plugins from disk?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(non_active)
		vim.notify(("Deleted %d non-active plugin(s)"):format(#non_active), vim.log.levels.INFO)
	end
end, { desc = "List non-active plugins and select to delete" })
