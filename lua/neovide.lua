if vim.g.neovide then
	vim.o.guifont = "MonoLisa,FiraMono Nerd Font:h11"
	vim.g.neovide_fullscreen = false
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_cursor_trail_size = 0
	vim.g.neovide_floating_shadow = false

	-- Animation
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_scroll_animation_far_lines = 0
	vim.g.neovide_scroll_animation_length = 0.3
	vim.g.neovide_position_animation_length = 0
	vim.g.neovide_cursor_animate_command_line = false

	vim.g.neovide_title_background_color = "#171513"
	vim.g.neovide_title_text_color = "#171513"
end
