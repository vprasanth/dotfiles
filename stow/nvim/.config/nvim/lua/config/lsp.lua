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

-- Performance optimizations for LSP
local function setup_lsp_performance()
	-- Reduce LSP update time
	vim.opt.updatetime = 100

	-- Configure diagnostic display
	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "always",
		},
	})

	-- Configure LSP signs
	local signs = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	}
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
end

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

	-- Enable formatting capabilities
	client.server_capabilities.documentFormattingProvider = true
	client.server_capabilities.documentRangeFormattingProvider = true

	-- Initialize change tracking for this client if supported
	if client:supports_method("textDocument/didChange") then
		vim.lsp._changetracking.init(client, bufnr)
	end
end

-- Global LSP flags
M.flags = {
	debounce_text_changes = 150, -- Debounce time for text changes in milliseconds
}

-- Add this to your setup function, before the Mason setup
local function setup_diagnostics()
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "✗",
                [vim.diagnostic.severity.WARN] = "⚠",
                [vim.diagnostic.severity.INFO] = "ℹ",
                [vim.diagnostic.severity.HINT] = "💡",
            },
        },
        virtual_text = {
            prefix = "●",
        },
        float = {
            source = "always",
        },
    })
end

--- Setup function that initializes Mason and configures LSP servers
M.setup = function()
	setup_diagnostics() -- Add this line
	-- Setup LSP performance optimizations
	setup_lsp_performance()

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
			"ts_ls",
			"ruff",
			"ruby_lsp",    -- Modern Ruby language server
			"sorbet",      -- Your type checker
			-- Remove rubocop from LSP, use it via formatter instead
			-- Remove solargraph to avoid conflicts with ruby_lsp
		},
		automatic_installation = true,
	})

	-- Setup LSP servers
  local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
		-- Lua language server configuration
		lua_ls = {
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
		ts_ls = {
			settings = {
				typescript = {
					format = { enable = true },
					inlayHints = { enabled = true },
					-- Performance optimizations
					suggest = {
						completeFunctionCalls = true,
					},
					updateImportsOnFileMove = "always",
					preferences = {
						includePackageJsonInImports = "off",
					},
				},
				javascript = {
					format = { enable = true },
					inlayHints = { enabled = true },
					-- Performance optimizations
					suggest = {
						completeFunctionCalls = true,
					},
					updateImportsOnFileMove = "always",
					preferences = {
						includePackageJsonInImports = "off",
					},
				},
			},
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
				},
			},
			root_dir = function(fname)
				return require("lspconfig.util").root_pattern("sorbet/config", ".git")(fname)
			end,
		},
		-- Add ruby_lsp configuration
		ruby_lsp = {
			settings = {
				ruby_lsp = {
					enabledFeatures = {
						diagnostics = true,
						documentSymbols = true,
						foldingRanges = true,
						selectionRanges = true,
						semanticHighlighting = true,
						formatting = false, -- Let RuboCop handle formatting
						codeActions = true,
					},
				},
			},
		},
	}

	-- List of LSP servers to configure
	local servers = {
		"lua_ls",
		"ts_ls",
		"ruff",
		"ruby_lsp",
		"sorbet",
	}

	-- Configure each LSP server with common and server-specific settings
	for _, server in ipairs(servers) do
		local settings = vim.tbl_deep_extend("force", common_settings, server_settings[server] or {})
		-- lspconfig[server].setup(settings)
    vim.lsp.enable(server)
	end
end

return M
