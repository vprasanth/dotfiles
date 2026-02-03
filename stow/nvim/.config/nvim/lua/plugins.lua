-- [[ plugins.lua ]]
return {
	-- [[ Core dependencies ]]
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- [[ UI and Theme ]]
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				backdrop = 0.95,
				width = 120,
				height = 1,
			},
			plugins = {
				options = {
					enabled = true,
					ruler = false,
					showcmd = false,
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "kyazdani42/nvim-web-devicons" },
			opts = {
				options = {
					theme = "auto",
					globalstatus = true,
				},
				sections = {
					lualine_x = {
						function()
							if vim.bo.filetype ~= "yaml" then
								return ""
							end
							local yaml = package.loaded["yaml_nvim"]
							if yaml and yaml.get_yaml_key_and_value then
								return yaml.get_yaml_key_and_value()
							end
							return ""
						end,
					},
				},
			},
		},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		dependencies = { "kyazdani42/nvim-web-devicons" },
		keys = {
			{ "<LEADER>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
		},
		opts = {
			disable_netrw = true,
			hijack_netrw = true,
			respect_buf_cwd = true,
			sync_root_with_cwd = true,
			actions = {
				change_dir = {
					enable = false,
				},
			},
			view = {
				adaptive_size = true,
				float = {
					enable = false,
				},
			},
			git = { enable = true },
			renderer = { highlight_git = true },
		},
	},

	-- [[ Theme Collection ]]
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		opts = {
			flavour = "mocha",
			transparent_background = false,
		},
	},
	{ "Mofiqul/dracula.nvim", lazy = true },
	{ "EdenEast/nightfox.nvim", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "rebelot/kanagawa.nvim", priority = 1000, lazy = false },
	{ "vague2k/vague.nvim", lazy = true },

	-- [[ Adaptive Theme ]]
	{
		"ilof2/posterpole.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("posterpole").setup({
				-- config here
			})
		end,
	},

	-- [[ Fuzzy Finder ]]
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.x",
		cmd = "Telescope",
		keys = {
			{ "<LEADER>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
			{ "<LEADER>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
			{ "<LEADER>fb", function() require("telescope.builtin").buffers() end, desc = "Find buffers" },
			{ "<LEADER>fh", function() require("telescope.builtin").help_tags() end, desc = "Find help tags" },
			{ "<LEADER>fm", function() require("telescope.builtin").marks() end, desc = "Find marks" },
			{ "<LEADER>ft", function() require("telescope.builtin").treesitter() end, desc = "Find treesitter symbols" },
			{ "<LEADER>fa", function() require("telescope.builtin").git_files() end, desc = "Find git files" },
			{ "<LEADER>fc", function() require("telescope.builtin").git_status() end, desc = "Find git files from status" },
			{ "<LEADER>fo", function() require("telescope.builtin").oldfiles() end, desc = "Find old files" },
			{ "<LEADER>fr", function() require("telescope.builtin").lsp_references() end, desc = "Find LSP references" },
			{ "<LEADER>fd", function() require("telescope.builtin").lsp_definitions() end, desc = "Find LSP definitions" },
			{ "<LEADER>fs", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Find LSP document symbols" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},
		},
		opts = function()
			local actions = require("telescope.actions")
			return {
				pickers = {
					git_status = {
						layout_config = {
							width = { padding = 0.1 },
							height = { padding = 0.1 },
						},
					},
					find_files = {
						layout_config = {
							width = { padding = 0.1 },
							height = { padding = 0.1 },
						},
					},
					live_grep = {
						layout_config = {
							width = { padding = 0.1 },
							height = { padding = 0.1 },
						},
					},
				},
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-r>"] = function(bufnr)
								require("telescope.actions.set").edit(bufnr, "tab drop")
							end,
						},
					},
				},
				extensions = {
					fzy_native = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			pcall(telescope.load_extension, "fzy_native")
			pcall(telescope.load_extension, "live_grep_args")
		end,
	},

	-- [[ LSP and Completion ]]
	{
		"williamboman/mason.nvim",
		lazy = false,
		priority = 100,
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		priority = 99,
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("config.lsp").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("config.cmp").setup()
		end,
	},

	-- [[ Git Integration ]]
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		keys = {
			{ "<LEADER>gb", function() require("gitsigns").blame_line() end, desc = "Git blame line" },
		},
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "│" },
			},
		},
	},
	{
		"ruifm/gitlinker.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
			callbacks = {
				["repos%.fullscript%.io"] = function(url_data)
					url_data.host = "git.fullscript.io"
					return require("gitlinker.hosts").get_gitlab_type_url(url_data)
				end,
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose" },
		keys = {
			{ "<LEADER>gd", "<cmd>DiffviewOpen<CR>", desc = "Open diff view" },
			{ "<LEADER>gc", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
		},
	},

	-- [[ Editor Enhancement ]]
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- New nvim-treesitter API (rewritten plugin)
			require("nvim-treesitter").setup({})

			-- Install parsers asynchronously
			require("nvim-treesitter").install({
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"json",
				"yaml",
				"javascript",
				"typescript",
				"tsx",
				"css",
				"markdown",
				"markdown_inline",
				"go",
				"python",
				"ruby",
				"embedded_template",
			})

			-- Enable treesitter highlighting for all supported filetypes
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"lua", "vim", "bash", "sh", "json", "yaml", "javascript", "typescript",
					"typescriptreact", "javascriptreact", "css", "markdown", "go", "python",
					"ruby", "eruby",
				},
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			-- Enable treesitter-based folding
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					if vim.treesitter.get_parser(0, nil, { error = false }) then
						vim.wo[0][0].foldmethod = "expr"
						vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.wo[0][0].foldenable = false -- Start with folds open
					end
				end,
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"tpope/vim-surround",
		event = "VeryLazy",
	},
	{
		"https://codeberg.org/andyg/leap.nvim",
		event = "VeryLazy",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		dependencies = "kyazdani42/nvim-web-devicons",
		keys = {
			{ "<LEADER>dd", "<cmd>Trouble diagnostics toggle<CR>", desc = "Toggle trouble" },
			{ "<LEADER>dw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" },
			{ "<LEADER>dl", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
		},
		opts = {},
	},

	{
		"cuducos/yaml.nvim",
		ft = { "yaml" }, -- optional
		dependencies = {
			"folke/snacks.nvim", -- optional
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		keys = {
			{
				"<LEADER>fy",
				function()
					require("yaml_nvim").telescope()
				end,
				desc = "YAML telescope fuzzy finder",
			},
		},
	},

	-- [[ Terminal ]]
	{
		"voldikss/vim-floaterm",
		cmd = { "FloatermNew", "FloatermToggle" },
		keys = {
			{ "<LEADER>tt", "<cmd>FloatermToggle<CR>", desc = "Toggle terminal" },
			{ "<LEADER>tn", "<cmd>FloatermNew<CR>", desc = "New terminal" },
		},
	},

	-- [[ Rails Support ]]
	{
		"tpope/vim-rails",
		ft = { "ruby", "eruby" },
	},
	{
		"tpope/vim-rake",
		ft = "ruby",
	},
	{
		"tpope/vim-projectionist",
		ft = { "ruby", "javascript", "typescript" },
	},

	-- [[ Formatting ]]
	{
		"mhartington/formatter.nvim",
		event = "VeryLazy",
		cmd = "Format",
		keys = {
			{ "<LEADER>f", "<cmd>Format<CR>", desc = "Format current buffer" },
		},
		config = function()
			local util = require("formatter.util")
			local function is_executable(cmd)
				return vim.fn.executable(cmd) == 1
			end
			local function rubocopConfig()
				if not is_executable("rubocop") then
					return nil
				end
				return {
					exe = "rubocop",
					args = { "--auto-correct", "--stdin", util.escape_path(util.get_current_buffer_file_path()) },
					stdin = true,
				}
			end
			local function eslintConfig()
				if not is_executable("eslint_d") then
					return nil
				end
				return {
					exe = "eslint_d",
					args = { "--stdin", "--stdin-filename", util.escape_path(util.get_current_buffer_file_path()), "--fix" },
					stdin = true,
				}
			end
			local prettierConfig = function()
				if not is_executable("prettier") then
					return nil
				end
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)) },
					stdin = true,
				}
			end

			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = {
					ruby = { rubocopConfig },
					json = { prettierConfig },
					html = { prettierConfig },
					javascript = { eslintConfig, prettierConfig },
					typescript = { eslintConfig, prettierConfig },
					typescriptreact = { eslintConfig, prettierConfig },
					go = {
						function()
							if not is_executable("gofmt") then
								return nil
							end
							return {
								exe = "gofmt",
								stdin = true,
							}
						end,
					},
					lua = {
						function()
							if not is_executable("stylua") then
								return nil
							end
							return require("formatter.filetypes.lua").stylua()
						end,
						function()
							if util.get_current_buffer_file_name() == "special.lua" then
								return nil
							end
							if not is_executable("stylua") then
								return nil
							end
							return {
								exe = "stylua",
								args = {
									"--search-parent-directories",
									"--stdin-filepath",
									util.escape_path(util.get_current_buffer_file_path()),
									"--",
									"-",
								},
								stdin = true,
							}
						end,
					},
					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})
		end,
	},

	-- [[ Misc ]]
	{ "mhinz/vim-startify", lazy = false },
	{ "danilamihailov/beacon.nvim", event = "VeryLazy" },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "wakatime/vim-wakatime", lazy = false },
}
