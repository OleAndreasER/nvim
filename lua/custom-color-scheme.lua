local M = {}

local colors = {
	fg = '#E8E6E3',

	bg = '#1A1816',
	window_separator = "#1E1C1A",
	floating_window = "#171513",

	type = '#E0C070',
	func = '#D16969',

	keyword = '#476B8A',
	-- keyword = '#4E5F7A',
	light_keyword = '#6285A6',
	string = '#86B3D1',

	comment = '#484848',

	search = '#4A3F5F',
	current_search = '#62567A',

	visual = "#34302C",

	-- diagnostics
	error = '#F44747',
	warn = '#FFCC66',
	info_and_hint = '#4FC1FF',
	ok = '#324232',

	-- git diffs
	green_dark = '#18231B',
	cyan = '#224040',
	cyan_dark = '#101B1C',
}

local function set(a, b) vim.api.nvim_set_hl(0, a, b) end

function M.colorscheme()
	vim.cmd('highlight clear');
	vim.cmd('syntax reset');

	vim.o.background = 'dark';
	vim.g.colors_name = 'custom-color-scheme';

	set('Normal', { bg = colors.bg, fg = colors.fg })
	set('Cursor', { bg = colors.fg, fg = colors.bg })
	set('Visual', { bg = colors.visual })
	set('Comment', { fg = colors.comment, italic = true })
	set('Constant', { link = "Identifier" })
	set('Identifier', { fg = colors.fg })
	set('String', { fg = colors.string })
	set('Function', {  fg = colors.func })
	set('Statement', {  fg = colors.keyword })
	set('Type', {  fg = colors.type })
	set('Special', {  fg = colors.fg })
	set('Error', {  fg = colors.func })
	set('Special', { fg = colors.type })
	set('Boolean', {  fg = colors.type })
	set('Number', {  fg = colors.type })
	set('Operator', { fg = colors.keyword })
    set('Title', { fg = colors.string })
    set('WinSeparator', { fg = colors.window_separator })
    set('NonText', { fg = colors.window_separator })
	set('Delimiter', { fg = colors.keyword })
	set('MatchParen', { fg = colors.light_keyword, bold = true })
	set('StatusLine', { link = 'Normal' })
	set('StatusLineNC', { link = 'Normal' })
	set('Search', { bg = colors.search })
	set('CurSearch', { bg = colors.current_search })

    set('NormalFloat', { link = 'Normal' });

    set('@tag', { link = 'Statement' });
    set('@tag.delimiter', { link = 'Delimiter' });
    set('@variable', { link = 'Identifier' });
    set('@variable.builtin', { link = 'Identifier' });
    set('@variable.member', { link = 'Identifier' });
    set('@variable.parameter', { link = 'Identifier' });
    set('@attribute.builtin', { link = 'Identifier' });
    set('@constant.builtin', { link = 'Type' });
    set('@module', { link = 'Function' });
    set('@markup.heading', { link = 'Statement' });
    set('@keyword.storage', { link = 'Statement' });
	set('@type', { link = 'Type' })
    set('@property', { link = 'Identifier' });
    set('@constructor.lua', { link = 'Delimiter' });
    set('@punctuation.special', { link = 'Delimiter' });
    set('@string.regexp', { link = 'Statement' });
    set('@character.special', { link = 'Statement' });
    set('@label', { link = "Statement" });
    set('@string.escape.typescript', { link = 'Statement' });
    set('@function.builtin.typescript', { link = 'Identifier' });


    set('@lsp.type.namespace', { link = 'Type' });
    set('@lsp.type.type', { link = 'Type' });
    set('@lsp.type.class', { link = 'Type' });
    set('@lsp.type.enum', { link = 'Type' });
    set('@lsp.type.enumMember', { link = 'Identifier' });
    set('@lsp.type.interface', { link = 'Type' });
    set('@lsp.type.struct', { link = 'Type' });
    set('@lsp.type.parameter', { link = 'Identifier' });
    set('@lsp.type.field', { link = 'Identifier' });
    set('@lsp.type.variable', { link = 'Identifier' });
    set('@lsp.type.property', { link = '@property' });
    set('@lsp.type.function', { link = 'Function' });
    set('@lsp.type.method', { link = 'Function' });
    set('@lsp.type.macro', { link = 'Type' });
    set('@lsp.type.decorator', { link = 'Type' });
    set('@lsp.type.boolean', { link = 'Boolean' });

    set('lualine_a_normal', { fg = colors.string, bg = colors.bg });
    set('lualine_a_inactive', { fg = colors.string, bg = colors.bg });
    set('lualine_a_insert', { fg = colors.string, bg = colors.bg });
    set('lualine_a_visual', { fg = colors.string, bg = colors.bg });
    set('lualine_a_replace', { fg = colors.string, bg = colors.bg });
    set('lualine_a_terminal', { fg = colors.string, bg = colors.bg });
    set('lualine_a_command', { fg = colors.string, bg = colors.bg });

    set('lualine_b_normal', { fg = colors.string, bg = colors.bg });
    set('lualine_b_inactive', { fg = colors.string, bg = colors.bg });
    set('lualine_b_insert', { fg = colors.string, bg = colors.bg });
    set('lualine_b_visual', { fg = colors.string, bg = colors.bg });
    set('lualine_b_replace', { fg = colors.string, bg = colors.bg });
    set('lualine_b_terminal', { fg = colors.string, bg = colors.bg });
    set('lualine_b_command', { fg = colors.string, bg = colors.bg });

    set('lualine_c_normal', { link = 'Normal' });
    set('lualine_c_inactive', { link = 'Normal' });
    set('lualine_c_insert', { link = 'Normal' });
    set('lualine_c_visual', { link = 'Normal' });
    set('lualine_c_replace', { link = 'Normal' });
    set('lualine_c_terminal', { link = 'Normal' });
    set('lualine_c_command', { link = 'Normal' });

    set('lualine_transparent', { link = 'Normal' });
    set('Folded', { link = 'Normal' });
    set('SnacksPicker', { bg = colors.floating_window });

    set('DiagnosticUnderlineError', { undercurl = true, sp = colors.error });
    set('DiagnosticUnderlineWarn', {  undercurl = true, sp = colors.warn });
    set('DiagnosticUnderlineInfo', { });
    set('DiagnosticUnderlineHint', { });
    set('DiagnosticUnderlineOk', { });

	set('DiagnosticError', { fg = colors.error });
	set('DiagnosticWarn', { fg = colors.warn });
	set('DiagnosticInfo', { fg = colors.info_and_hint });
	set('DiagnosticHint', { fg = colors.info_and_hint });
	set('DiagnosticOk', { fg = colors.ok });

	set('MiniIconsAzure', { fg = colors.string });
	set('MiniIconsGreen', { fg = colors.type });
	set('MiniIconsPurple', { fg = colors.current_search });
	set('MiniIconsBlue', { fg = colors.keyword });

	set('DiffAdd', { bg = colors.green_dark });
	set('DiffChange', { bg = colors.cyan_dark });
	set('DiffText', { bg = colors.cyan });

	-- Terminal
	vim.g.terminal_color_0  = '#1A1816'
	vim.g.terminal_color_1  = colors.error
	vim.g.terminal_color_2  = colors.type
	vim.g.terminal_color_3  = colors.warn
	vim.g.terminal_color_4  = colors.keyword
	vim.g.terminal_color_5  = colors.func
	vim.g.terminal_color_6  = colors.cyan
	vim.g.terminal_color_7  = colors.fg
	vim.g.terminal_color_8  = '#484848'
	vim.g.terminal_color_9  = colors.error
	vim.g.terminal_color_10 = colors.type
	vim.g.terminal_color_11 = colors.warn
	vim.g.terminal_color_12 = colors.light_keyword
	vim.g.terminal_color_13 = colors.func
	vim.g.terminal_color_14 = colors.cyan
	vim.g.terminal_color_15 = '#FFFFFF'

end

-- M.colorscheme()
-- vim.diagnostic.disable()
-- vim.keymap.set('n', '<leader>l', ':lua Snacks.picker.highlights()<cr>')

return M
