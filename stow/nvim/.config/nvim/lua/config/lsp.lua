--[[ lsp.lua ]]
-- Language Server Protocol (LSP) configuration for Neovim
--
-- This module configures the LSP client for various programming languages.
-- It uses Mason for managing LSP servers and provides common configuration
-- for all language servers while allowing server-specific customizations.
--
-- Key features:
-- - Automatic server installation via Mason
-- - Common keybindings for LSP features
-- - Server-specific settings for optimal performance
-- - Change tracking for efficient text synchronization
-- - Formatting and diagnostic capabilities

local M = {}

--- LSP on_attach function that runs when a language server attaches to a buffer
--- @param client table The LSP client instance
--- @param bufnr number The buffer number
M.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Set buffer local keymaps for LSP features
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- Key mappings for common LSP operations:
	-- gD: Go to declaration
	-- gd: Go to definition
	-- K: Show hover documentation
	-- gi: Go to implementation
	-- <C-k>: Show signature help
	-- <space>wa/wr/wl: Workspace folder operations
	-- <space>D: Go to type definition
	-- <space>rn: Rename symbol
	-- <space>ca: Code actions
	-- gr: Show references
	-- <space>f: Format document
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		local clients = vim.lsp.get_clients()
		local folders = {}
		for _, client in ipairs(clients) do
			if client.workspaceFolders then
				for _, folder in ipairs(client.workspaceFolders) do
					table.insert(folders, folder.name)
				end
			end
		end
		print(vim.inspect(folders))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)
end

-- Global LSP flags
M.flags = {
	debounce_text_changes = 200, -- Debounce time for text changes in milliseconds (increased for large projects)
}

--- Setup function that initializes Mason and configures LSP servers
M.setup = function()
	-- Configure Mason package manager
	require("mason").setup({
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
		max_concurrent_installers = 4, -- Limit concurrent installations
	})

	-- Configure Mason LSP installer
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
			"vtsls",
			"ruff",
			"gopls",
			-- Remove rubocop from LSP, use it via formatter instead
			-- Remove solargraph to avoid conflicts with ruby_lsp
		},
		automatic_installation = false,
	})

	-- Setup LSP servers (native config)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if ok_cmp then
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	end

	-- Common settings for all LSP servers
	local common_settings = {
		on_attach = M.on_attach,
		flags = M.flags,
		capabilities = capabilities,
		init_options = {
			position_encoding = "utf-16", -- Consistent position encoding for all servers
		},
	}

	-- Server-specific settings and configurations
	local server_settings = {
		-- Go language server configuration
		gopls = {
			cmd = { "gopls" },
			settings = {
				gopls = {
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
						nilness = true,
						shadow = true,
						unreachable = true,
					},
					staticcheck = true,
				},
			},
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = function(fname)
				return vim.fs.root(fname, { "go.work", "go.mod", ".git" }) or vim.fn.getcwd()
			end,
		},
		-- Lua language server configuration
		lua_ls = {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						maxPreload = 1000,
						preloadFileSize = 100,
					},
					telemetry = { enable = false },
				},
			},
		},
		-- TypeScript/JavaScript language server configuration
		vtsls = {
			cmd = { "vtsls", "--stdio" },
			filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
			root_dir = function(fname)
				return vim.fs.root(fname, { "tsconfig.json", "package.json", ".git" }) or vim.fn.getcwd()
			end,
			settings = {
				vtsls = {
					autoUseWorkspaceTsdk = true,
					experimental = {
						maxInlayHintLength = 40,
					},
				},
				typescript = {
					updateImportsOnFileMove = "always",
					preferences = {
						includePackageJsonInImports = "off",
					},
					inlayHints = { enabled = true },
				},
				javascript = {
					updateImportsOnFileMove = "always",
					preferences = {
						includePackageJsonInImports = "off",
					},
					inlayHints = { enabled = true },
				},
			},
			single_file_support = false,
		},
		-- Python linter/formatter
		ruff = {
			cmd = { "ruff", "server" },
			filetypes = { "python" },
		},
		-- Ruby language server configuration
		rubocop = {
			cmd = { "bundle", "exec", "rubocop", "--lsp" },
			settings = {
				rubocop = {
					useBundler = true,
				},
			},
		},
		-- Ruby type checker configuration
		sorbet = {
			cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
			settings = {
				sorbet = {
					commandPath = "bundle exec srb",
					logLevel = "warn",
					highlightUntyped = false, -- Reduce noise in untyped files
				},
			},
		},
		-- Add ruby_lsp configuration
		ruby_lsp = {
			cmd = { "ruby-lsp" },
			init_options = {
				experimentalFeaturesEnabled = false,
				enabledFeatures = {
					codeActions = true,
					codeLens = false,
					completion = true,
					definition = true,
					diagnostics = true,
					documentHighlights = true,
					documentLink = true,
					documentSymbols = true,
					foldingRanges = false, -- Disable for performance
					formatting = false, -- Let RuboCop handle formatting
					hover = true,
					inlayHint = false, -- Disable for performance
					onTypeFormatting = false,
					selectionRanges = true,
					semanticHighlighting = true,
					signatureHelp = true,
					typeHierarchy = true,
				},
			},
		},
	}

	-- List of LSP servers to configure
	local servers = {
		"lua_ls",
		"vtsls",
		"ruff",
		"gopls",
	}

	-- Configure each LSP server with common and server-specific settings
	for _, server in ipairs(servers) do
		local settings = vim.tbl_deep_extend("force", common_settings, server_settings[server] or {})
		vim.lsp.config(server, settings)
		vim.lsp.enable(server)
	end

	-- Configure Ruby servers with explicit filetypes for safe autostart
	for _, server in ipairs({ "ruby_lsp", "sorbet" }) do
		local settings = vim.tbl_deep_extend("force", common_settings, server_settings[server] or {})
		settings.filetypes = { "ruby", "eruby" }
		vim.lsp.config(server, settings)
		vim.lsp.enable(server)
	end
end

return M
