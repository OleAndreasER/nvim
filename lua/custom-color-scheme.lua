local M = {}

local colors = {
	darker = '#191919',
	bg = '#1C1C1C',
	grey1 = "#1F1F1F",
	grey2 = "#3B3B3B",
	string = "#8DBEE8",
	visual = "#2F2F2F",
	fg = '#F5E8D8',
	fn = '#EF767A',      -- REDish
	type = '#70AD47',    -- GREEN
	keyword = '#4D7EA8', -- BLUE
	light_keyword = "#ADBEE8",
	search = '#3E2F5B',
	curSearch = '#5E4F7B',
	warn = '#ECA400',
	error = '#923141',
    info = '#B3FFFC',
    hint = '#B3FFFC',
    ok = '#232E21',
	green_dark = '#1F301F',
	cyan = '#1C5C5C',
	cyan_dark = '#152525'
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
	set('Comment', { fg = colors.grey2, italic = true })
	set('Constant', { link = "Identifier" })
	set('Identifier', { fg = colors.fg })
	set('String', { fg = colors.string })
	set('Function', {  fg = colors.fn })
	set('Statement', {  fg = colors.keyword })
	set('Type', {  fg = colors.type })
	set('Special', {  fg = colors.fg })
	set('Error', {  fg = colors.fn })
	set('Special', { fg = colors.type })
	set('Boolean', {  fg = colors.type })
	set('Number', {  fg = colors.type })
	set('Operator', { fg = colors.keyword })
    set('Title', { fg = colors.string })
    set('WinSeparator', { fg = colors.grey1 })
    set('NonText', { fg = colors.grey1 })
	set('Delimiter', { fg = colors.keyword })
	set('MatchParen', { fg = colors.light_keyword, bold = true })
	set('StatusLine', { link = 'Normal' })
	set('StatusLineNC', { link = 'Normal' })
	set('Search', { bg = colors.search })
	set('CurSearch', { bg = colors.curSearch })

    -- set('NormalFloat', { bg = colors.darker });
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
    set('SnacksPicker', { bg = colors.darker });

    set('DiagnosticUnderlineError', { undercurl = true, sp = colors.error });
    set('DiagnosticUnderlineWarn', {  undercurl = true, sp = colors.warn });
    set('DiagnosticUnderlineInfo', { });
    set('DiagnosticUnderlineHint', { });
    set('DiagnosticUnderlineOk', { });

	set('DiagnosticError', { fg = colors.error });
	set('DiagnosticWarn', { fg = colors.warn });
	set('DiagnosticInfo', { fg = colors.info });
	set('DiagnosticHint', { fg = colors.hint });
	set('DiagnosticOk', { fg = colors.ok });

	set('MiniIconsAzure', { fg = colors.string });
	set('MiniIconsGreen', { fg = colors.type });
	set('MiniIconsPurple', { fg = colors.curSearch });
	set('MiniIconsBlue', { fg = colors.keyword });

	set('DiffAdd', { bg = colors.green_dark });
	set('DiffChange', { bg = colors.cyan_dark });
	set('DiffText', { bg = colors.cyan });

end

-- M.colorscheme()
-- vim.diagnostic.enable()
-- vim.keymap.set('n', '<leader>l', ':lua Snacks.picker.highlights()<cr>')

return M
