-- https://github.com/mfussenegger/nvim-dap
--- @module "lazy"
--- @type LazySpec
return {
	{
		enabled = false,
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = "OpenDebugAD7",
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					-- stopAtEntry = true,
				},
				-- {
				-- 	name = "Attach to gdbserver :1234",
				-- 	type = "cppdbg",
				-- 	request = "launch",
				-- 	MIMode = "gdb",
				-- 	miDebuggerServerAddress = "localhost:1234",
				-- 	miDebuggerPath = "/usr/bin/gdb",
				-- 	cwd = "${workspaceFolder}",
				--
				-- 	program = function()
				-- 		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				-- 	end,
				-- },
			}

			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

			dap.defaults.fallback.force_external_terminal = true
			dap.defaults.fallback.external_terminal = {
				command = "tmux",
				args = { "new-window" },
			}

			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end, { desc = "Continue" })
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end, { desc = "Step over" })
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end, { desc = "Step into" })
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end, { desc = "Step out" })
			vim.keymap.set("n", "<Leader>bp", function()
				require("dap").toggle_breakpoint()
			end, { desc = "Breakpoint" })
			-- vim.keymap.set("n", "<Leader>lp", function()
			-- 	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			-- end)
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end, { desc = "Debug repl" })
			-- vim.keymap.set("n", "<Leader>dl", function()
			-- 	require("dap").run_last()
			-- end)
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "Debug hover" })
			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end, { desc = "Debug frames" })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dap-float",
				callback = function()
					vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<CR>", { noremap = true, silent = true })
				end,
			})
		end,
	},
	{
		enabled = false,
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		opts = {
			virt_text_pos = "eol",
			only_first_definition = false,
		},
	},
}
