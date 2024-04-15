-- Based on: https://github.com/zapling/mason-conform.nvim
-- conform formatter to mason package mapping
-- https://mason-registry.dev/registry/list
local conform_to_mason = {
	-- alejandra
	["asmfmt"] = "asmfmt",
	["ast-grep"] = "ast-grep",
	-- astyle
	-- auto_optional
	-- autocorrect
	["autoflake"] = "autoflake",
	["autopep8"] = "autopep8",
	-- awk
	-- bean-format
	["beautysh"] = "beautysh",
	["bibtex-tidy"] = "bibtex-tidy",
	-- biome-check
	["biome"] = "biome",
	["black"] = "black",
	["blade-formatter"] = "blade-formatter",
	["blue"] = "blue",
	["buf"] = "buf",
	["buildifier"] = "buildifier",
	["cbfmt"] = "cbfmt",
	["clang-format"] = "clang-format",
	-- cljstyle
	["cmake_format"] = "cmakelang",
	["codespell"] = "codespell",
	["csharpier"] = "csharpier",
	-- cue_fmt
	["darker"] = "darker",
	-- dart_format
	["deno_fmt"] = "deno",
	-- dfmt
	["djlint"] = "djlint",
	["dprint"] = "dprint",
	["easy-coding-standard"] = "easy-coding-standard",
	["elm_format"] = "elm-format",
	-- erb_format
	["eslint_d"] = "eslint_d",
	["fantomas"] = "fantomas",
	-- fish_indent
	["fixjson"] = "fixjson",
	-- fnlfmt
	["fourmolu"] = "fourmolu",
	["gci"] = "gci",
	["gdformat"] = "gdtoolkit",
	["gersemi"] = "gersemi",
	-- gn
	-- gofmt
	["gofumpt"] = "gofumpt",
	["goimports-reviser"] = "goimports-reviser",
	["goimports"] = "goimports",
	["golines"] = "golines",
	["google-java-format"] = "google-java-format",
	["htmlbeautifier"] = "htmlbeautifier",
	-- indent
	-- init
	-- injected
	["isort"] = "isort",
	["joker"] = "joker",
	["jq"] = "jq",
	["jsonnetfmt"] = "jsonnetfmt",
	-- just
	["ktlint"] = "ktlint",
	["latexindent"] = "latexindent",
	["markdown-toc"] = "markdown-toc",
	["markdownlint-cli2"] = "markdownlint-cli2",
	["markdownlint"] = "markdownlint",
	["mdformat"] = "mdformat",
	["mdslw"] = "mdslw",
	-- mix
	-- nixfmt
	["nixpkgs_fmt"] = "nixpkgs-fmt",
	["ocamlformat"] = "ocamlformat",
	-- opa_fmt
	-- packer_fmt
	-- pangu
	-- perlimports
	-- perltidy
	-- pg_format
	["php_cs_fixer"] = "php-cs-fixer",
	["phpcbf"] = "phpcbf",
	-- phpinsights
	["pint"] = "pint",
	["prettier"] = "prettier",
	["prettierd"] = "prettierd",
	["pretty-php"] = "pretty-php",
	-- puppet-lint
	["reorder-python-imports"] = "reorder-python-imports",
	-- rescript-format
	["rubocop"] = "rubocop",
	["rubyfmt"] = "rubyfmt",
	-- ruff
	["ruff_fix"] = "ruff",
	["ruff_format"] = "ruff",
	["rufo"] = "rufo",
	-- NOTE: Should install through rustup instead
	-- ["rustfmt"] = "rustfmt",
	["rustywind"] = "rustywind",
	-- scalafmt
	["shellcheck"] = "shellcheck",
	["shellharden"] = "shellharden",
	["shfmt"] = "shfmt",
	["sql_formatter"] = "sql-formatter",
	["sqlfluff"] = "sqlfluff",
	["sqlfmt"] = "sqlfmt",
	-- squeeze_blanks
	["standardjs"] = "standardjs",
	["standardrb"] = "standardrb",
	["stylelint"] = "stylelint",
	-- styler
	["stylua"] = "stylua",
	-- swift_format
	-- swiftformat
	["taplo"] = "taplo",
	["templ"] = "templ",
	-- terraform_fmt
	-- terragrunt_hclfmt
	["tlint"] = "tlint",
	-- trim_newlines
	-- trim_whitespace
	-- twig-cs-fixer
	["typos"] = "typos",
	-- typstfmt
	-- uncrustify
	["usort"] = "usort",
	["xmlformat"] = "xmlformatter",
	-- xmllint
	["yamlfix"] = "yamlfix",
	["yamlfmt"] = "yamlfmt",
	["yapf"] = "yapf",
	["yq"] = "yq",
	-- zigfmt
	["zprint"] = "zprint",
}

local M = {}

function M.process_formatters(formatters_by_ft)
	local formatters_to_install = {}
	for _, formatters in pairs(formatters_by_ft) do
		for _, formatter in pairs(formatters) do
			if type(formatter) == "table" then
				for _, f in pairs(formatter) do
					local package = conform_to_mason[f]
					if package ~= nil then
						formatters_to_install[package] = 1
					end
				end
			end
			local package = conform_to_mason[formatter]
			if package ~= nil then
				formatters_to_install[package] = 1
			end
		end
	end

	return vim.tbl_keys(formatters_to_install)
end

return M
