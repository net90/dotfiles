local on_attach = require("utils.lsp").on_attach
local diagnostic_signs = require("utils.icons").diagnostic_signs

local config = function()
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")
	local capabilities = cmp_nvim_lsp.default_capabilities()

	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	-- C/C++
	lspconfig.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
	})

	-- GLSL
	lspconfig.glslls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"glsl",
			"vert",
			"tesc",
			"tese",
			"frag",
			"geom",
			"comp",
		},
		cmd = {
			"glslls",
			"--stdin",
		},
	})

	-- Rust
	lspconfig.rust_analyzer.setup({
		capabilities = {
			experimental = {
				serverStatusNotification = true,
			},
			general = {
				positionEncodings = { "utf-16" },
			},
			textDocument = {
				callHierarchy = {
					dynamicRegistration = false,
				},
				codeAction = {
					codeActionLiteralSupport = {
						codeActionKind = {
							valueSet = {
								"",
								"quickfix",
								"refactor",
								"refactor.extract",
								"refactor.inline",
								"refactor.rewrite",
								"source",
								"source.organizeImports",
							},
						},
					},
					dataSupport = true,
					dynamicRegistration = true,
					isPreferredSupport = true,
					resolveSupport = {
						properties = { "edit" },
					},
				},
				completion = {
					completionItem = {
						commitCharactersSupport = false,
						deprecatedSupport = false,
						documentationFormat = { "markdown", "plaintext" },
						preselectSupport = false,
						snippetSupport = false,
					},
					completionItemKind = {
						valueSet = {
							1,
							2,
							3,
							4,
							5,
							6,
							7,
							8,
							9,
							10,
							11,
							12,
							13,
							14,
							15,
							16,
							17,
							18,
							19,
							20,
							21,
							22,
							23,
							24,
							25,
						},
					},
					contextSupport = false,
					dynamicRegistration = false,
				},
				declaration = {
					linkSupport = true,
				},
				definition = {
					dynamicRegistration = true,
					linkSupport = true,
				},
				diagnostic = {
					dynamicRegistration = false,
				},
				documentHighlight = {
					dynamicRegistration = false,
				},
				documentSymbol = {
					dynamicRegistration = false,
					hierarchicalDocumentSymbolSupport = true,
					symbolKind = {
						valueSet = {
							1,
							2,
							3,
							4,
							5,
							6,
							7,
							8,
							9,
							10,
							11,
							12,
							13,
							14,
							15,
							16,
							17,
							18,
							19,
							20,
							21,
							22,
							23,
							24,
							25,
							26,
						},
					},
				},
				formatting = {
					dynamicRegistration = true,
				},
				hover = {
					contentFormat = { "markdown", "plaintext" },
					dynamicRegistration = true,
				},
				implementation = {
					linkSupport = true,
				},
				inlayHint = {
					dynamicRegistration = true,
					resolveSupport = {
						properties = { "textEdits", "tooltip", "location", "command" },
					},
				},
				publishDiagnostics = {
					dataSupport = true,
					relatedInformation = true,
					tagSupport = {
						valueSet = { 1, 2 },
					},
				},
				rangeFormatting = {
					dynamicRegistration = true,
				},
				references = {
					dynamicRegistration = false,
				},
				rename = {
					dynamicRegistration = true,
					prepareSupport = true,
				},
				semanticTokens = {
					augmentsSyntaxTokens = true,
					dynamicRegistration = false,
					formats = { "relative" },
					multilineTokenSupport = false,
					overlappingTokenSupport = true,
					requests = {
						full = {
							delta = true,
						},
						range = false,
					},
					serverCancelSupport = false,
					tokenModifiers = {
						"declaration",
						"definition",
						"readonly",
						"static",
						"deprecated",
						"abstract",
						"async",
						"modification",
						"documentation",
						"defaultLibrary",
					},
					tokenTypes = {
						"namespace",
						"type",
						"class",
						"enum",
						"interface",
						"struct",
						"typeParameter",
						"parameter",
						"variable",
						"property",
						"enumMember",
						"event",
						"function",
						"method",
						"macro",
						"keyword",
						"modifier",
						"comment",
						"string",
						"number",
						"regexp",
						"operator",
						"decorator",
					},
				},
				signatureHelp = {
					dynamicRegistration = false,
					signatureInformation = {
						activeParameterSupport = true,
						documentationFormat = { "markdown", "plaintext" },
						parameterInformation = {
							labelOffsetSupport = true,
						},
					},
				},
				synchronization = {
					didSave = true,
					dynamicRegistration = false,
					willSave = true,
					willSaveWaitUntil = true,
				},
				typeDefinition = {
					linkSupport = true,
				},
			},
			window = {
				showDocument = {
					support = true,
				},
				showMessage = {
					messageActionItem = {
						additionalPropertiesSupport = false,
					},
				},
				workDoneProgress = true,
			},
			workspace = {
				applyEdit = true,
				configuration = true,
				didChangeConfiguration = {
					dynamicRegistration = false,
				},
				didChangeWatchedFiles = {
					dynamicRegistration = true,
					relativePatternSupport = true,
				},
				inlayHint = {
					refreshSupport = true,
				},
				semanticTokens = {
					refreshSupport = true,
				},
				symbol = {
					dynamicRegistration = false,
					symbolKind = {
						valueSet = {
							1,
							2,
							3,
							4,
							5,
							6,
							7,
							8,
							9,
							10,
							11,
							12,
							13,
							14,
							15,
							16,
							17,
							18,
							19,
							20,
							21,
							22,
							23,
							24,
							25,
							26,
						},
					},
				},
				workspaceEdit = {
					resourceOperations = { "rename", "create", "delete" },
				},
				workspaceFolders = true,
			},
		},
		on_attach = on_attach,
		cmd = {
			"rust_analyzer",
		},
	})

	-- Haskell
	lspconfig.hls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			-- "haskell-language-server-wrapper",
			-- "--lsp",
		},
		filetypes = {
			"haskell",
			"lhaskell",
		},
	})

	-- docker
	lspconfig.dockerls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local cpplint = require("efmls-configs.linters.cpplint")
	local clangformat = require("efmls-configs.formatters.clang_format")
	local fourmolu = require("efmls-configs.formatters.fourmolu")
	local prettier_d = require("efmls-configs.formatters.prettier_d")
  local hadolint = require("efmls-configs.linters.hadolint")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"c",
			"cpp",
			"rust",
			"docker",
			"haskell",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				c = { clangformat, cpplint },
				cpp = { clangformat, cpplint },
				haskell = { fourmolu },
				docker = { hadolint, prettier_d },
			},
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
