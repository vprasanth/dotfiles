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
	-- TypeScript/JavaScript - native Neovim integration, better for large projects
	{
		"pmizio/typescript-tools.nvim",
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			settings = {
				-- Memory optimization for large projects
				tsserver_max_memory = 8192,
				-- Faster startup by not checking all files
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "none",
					includeInlayPropertyDeclarationTypeHints = false,
					includeInlayFunctionLikeReturnTypeHints = false,
				},
				-- Separate diagnostic server for better responsiveness
				separate_diagnostic_server = true,
				-- Don't report style issues (let eslint handle those)
				publish_diagnostic_on = "insert_leave",
			},
			on_attach = require("config.lsp").on_attach,
		},
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
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<LEADER>gd", "<cmd>DiffviewOpen<CR>", desc = "Open diff view" },
			{ "<LEADER>gc", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
			{ "<LEADER>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history (current file)" },
			{ "<LEADER>gH", "<cmd>DiffviewFileHistory<CR>", desc = "File history (repo)" },
			{
				"<LEADER>gD",
				function()
					local target = vim.g.diffview_target
					if type(target) ~= "string" or target == "" then
						local git_dir = vim.fs.find(".git", { upward = true })[1]
						if git_dir then
							local root = vim.fs.dirname(git_dir)
							local ok, lines = pcall(vim.fn.readfile, root .. "/.diffview-target")
							if ok and lines[1] and lines[1] ~= "" then
								target = vim.fn.trim(lines[1])
							end
						end
					end
					target = target or "origin/main"
					vim.cmd("DiffviewOpen " .. target .. "...HEAD")
				end,
				desc = "Diffview compare vs target",
			},
		},
	},
	{
		"harrisoncramer/gitlab.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"stevearc/dressing.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		build = function()
			require("gitlab.server").build(true)
		end,
		keys = {
			{
				"<LEADER>gr",
				function()
					require("gitlab").review()
				end,
				desc = "GitLab review MR",
			},
			{
				"<LEADER>gR",
				function()
					require("gitlab").choose_merge_request()
				end,
				desc = "GitLab choose MR",
			},
			{
				"<LEADER>gM",
				"glo",
				desc = "GitLab open MR in browser",
				remap = true,
			},
		},
		config = function()
			require("gitlab").setup()
		end,
	},
	-- [[ Notes ]]
	{
		"yujinyuz/gitpad.nvim",
		keys = {
			{
				"<LEADER>pp",
				function()
					require("gitpad").toggle_gitpad()
				end,
				desc = "Gitpad project notes",
			},
			{
				"<LEADER>pb",
				function()
					require("gitpad").toggle_gitpad_branch()
				end,
				desc = "Gitpad branch notes",
			},
			{
				"<LEADER>pd",
				function()
					local date_filename = "daily-" .. os.date("%Y-%m-%d") .. ".md"
					require("gitpad").toggle_gitpad({ filename = date_filename })
				end,
				desc = "Gitpad daily notes",
			},
			{
				"<LEADER>pf",
				function()
					local filename = vim.fn.expand("%:p")
					if filename == "" then
						vim.notify("empty bufname", vim.log.levels.WARN)
						return
					end
					filename = vim.fn.pathshorten(filename, 2) .. ".md"
					require("gitpad").toggle_gitpad({ filename = filename })
				end,
				desc = "Gitpad per file notes",
			},
		},
		opts = {},
	},
	{
		"folke/snacks.nvim",
		keys = {
			{ "<LEADER>.", function() Snacks.scratch() end, desc = "Scratch buffer" },
			{ "<LEADER>S", function() Snacks.scratch.select() end, desc = "Scratch buffer select" },
		},
		opts = {
			scratch = { enabled = true },
		},
	},

	-- [[ Keymap Helper ]]
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 300, -- delay before showing popup (ms)
			icons = {
				mappings = false, -- disable icons for cleaner look
			},
			spec = {
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },
				{ "<leader>d", group = "diagnostics" },
				{ "<leader>p", group = "notes" },
				{ "<leader>t", group = "terminal" },
			},
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

			-- Enable treesitter highlighting for all buffers with a parser
			vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
				callback = function()
					local buf = vim.api.nvim_get_current_buf()
					-- Only start if parser exists and highlighter isn't already active
					if vim.treesitter.get_parser(buf, nil, { error = false })
						and not vim.treesitter.highlighter.active[buf] then
						pcall(vim.treesitter.start)
					end
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
