local function uv_script_interpreter(script_path)
	local result = vim.system({ "uv", "python", "find", "--script", script_path }, { text = true }):wait()
	if result.code == 0 then
		return vim.fn.trim(result.stdout)
	end
end

local function uv_interpreter()
	local result = vim.system({ "uv", "python", "find" }, { text = true }):wait()
	if result.code == 0 then
		return vim.fn.trim(result.stdout)
	end
end

return {
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "standard",
			},
		},
		python = {},
	},
	before_init = function(_, config)
		local script = vim.api.nvim_buf_get_name(0)
		local python = uv_script_interpreter(script)
		if not python then
			python = uv_interpreter()
		end
		config.settings.python.pythonPath = python
	end,
}
