vim.pack.add({ 'https://github.com/dmtrKovalenko/fff.nvim', })

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('fff.nvim') end
      require('fff.download').download_or_build_binary()
    end
  end,
})

vim.g.fff = {
  lazy_sync = true,
  debug = { enabled = false, show_scores = false },
}


require('fff').setup({
	prompt_vim_mode = true,
	prompt = '> ',
	title = 'Files',
})

-- On selecting file, first switch to main tab.
local original_select = require('fff.picker_ui').select
require('fff.picker_ui').select = function(input)
	require('tab-management').set_tab('main')
	return original_select(input)
end

vim.keymap.set('n', '<leader>f', function()
	require('fff').find_files({ 
		layout = {
			height = 1,
			width = 0.76,
			prompt_position = 'bottom',
			preview_position = 'bottom',
			preview_size = 0.7,
			flex = { size = 130, wrap = 'top' },
			show_scrollbar = false,
			path_shorten_strategy = 'middle_number',
			anchor = 'top',
		},
	})
end)
vim.keymap.set('n', '<leader>s', function()
	require('fff').live_grep({
		layout = {
			height = 1,
			width = 0.76,
			prompt_position = 'top',
			preview_position = 'top',
			preview_size = 0.5,
			flex = { size = 130, wrap = 'top' },
			show_scrollbar = false,
			path_shorten_strategy = 'middle_number',
			anchor = 'top',
		}
	}) 
end)
