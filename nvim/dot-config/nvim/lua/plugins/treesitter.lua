-- https://github.com/nvim-treesitter/nvim-treesitter
--- @module "lazy"
--- @type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		-- Taken from kickstart.nvim
		config = function()
			-- ensure basic parser are installed
			local parsers = {
				"c",
				"cpp",
				"go",
				"lua",
				"python",
				"rust",
				"tsx",
				"typescript",
				"vimdoc",
				"vim",
				"markdown",
				"markdown_inline",
				"bash",
				"sql",
				"xml",
				"cmake",
				"json",
				"yaml",
			}
			require("nvim-treesitter").install(parsers)

			---@param buf integer
			---@param language string
			local function treesitter_try_attach(buf, language)
				-- Check if the parser exists
				if not vim.treesitter.language.add(language) then
					return
				end
				vim.treesitter.start(buf, language)

				-- TODO: Does this work properly?
				local has_fold_query = vim.treesitter.query.get(language, "folds") ~= nil
				if has_fold_query then
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end

				local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil
				if has_indent_query then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end

			local available_parsers = require("nvim-treesitter").get_available()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					local installed_parsers = require("nvim-treesitter").get_installed("parsers")

					if vim.tbl_contains(installed_parsers, language) then
						-- enable the parser if it is installed
						treesitter_try_attach(buf, language)
					elseif vim.tbl_contains(available_parsers, language) then
						-- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
						require("nvim-treesitter").install(language):await(function()
							treesitter_try_attach(buf, language)
						end)
					else
						-- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
						treesitter_try_attach(buf, language)
					end
				end,
			})
		end,
	},
}
