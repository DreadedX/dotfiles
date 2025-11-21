return {
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = {
					"./definitions",
				},
			},
			telemetry = { enable = false },
			type = {
				checkTableShape = true,
			},
			diagnostics = {
				neededFileStatus = {
					-- ["no-unknown"] = "Opened",
					-- ["incomplete-signature-doc"] = "Opened",
					-- ["await-in-sync"] = "Opened",
				},
			},
		},
	},
}
