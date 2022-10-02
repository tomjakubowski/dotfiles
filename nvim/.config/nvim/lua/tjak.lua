local M = {}

M.reload = function(modname)
	-- NOTE: should this also require the module again?
	-- NOTE: this does reload any modules matching modname - so reload("tjak")
	-- would reload this and all the tjak.* modules
	require("plenary.reload").reload_module(modname)
end

M.setopts = function(opts)
	-- setopts({"foo", xwidth=1})
	for k, v in pairs(opts) do
		if type(k) == "string" then
			vim.opt[k] = v
		elseif type(k) == "number" and type(v) == "string" then
			vim.opt[v] = true
		end
	end
end

return M
