if vim.g.neovide then
	vim.o.guifont = "MonoLisa,FiraMono Nerd Font:h11"
	vim.g.neovide_fullscreen = false
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_cursor_trail_size = 0
	vim.g.neovide_floating_shadow = false

	-- Animation
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_scroll_animation_far_lines = 0
	vim.g.neovide_scroll_animation_length = 0
	vim.g.neovide_position_animation_length = 0
	vim.g.neovide_cursor_animate_command_line = false


	-- Silly transparent toggle
	local is_transparent = false
	vim.keymap.set("n", "<leader>o", function ()
		is_transparent = not is_transparent
		if is_transparent then
			vim.g.neovide_opacity = 1
			vim.g.neovide_normal_opacity = 1
		else 
			vim.g.neovide_opacity = 0.6
			vim.g.neovide_normal_opacity = 0.6
		end
	end)

end
