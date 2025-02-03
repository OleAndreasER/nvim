return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function() 
		require('neo-tree').setup({
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"document_symbols",
			},
			hide_root_node = true,
			retain_hidden_root_indent = true,
			log_level = "error",
			window = {
				width = 30,
				mappings = {
					["e"] = {
                        function(state)
                            local function expand(u)
                                if u == nil then return end
                                if not u:is_expanded() then u:expand() end
                                for _, v in ipairs(state.tree:get_nodes(u:get_id())) do
                                    expand(v)
                                end
                            end
                            require('plenary.async').run(function()
                                expand(state.tree:get_nodes()[1])
                            end, function()
                                require("neo-tree.ui.renderer").redraw(state)
                            end)
                        end,
                        desc = 'expand_all_nodes',
                    },
				}
			},
			document_symbols = {
				follow_cursor = false,
				client_filters = "first",
				renderers = {
					symbol = {
						{"indent", with_expanders = true, align = "right"},
						-- {"kind_icon", default=" ", align = "right" },
						{"name", zindex = 10, align = "right"},
						-- {"kind_name", zindex = 20, align = "right"},
					},

				},
			},
		})

		vim.cmd('Neotree document_symbols show');
		
	end,
}
