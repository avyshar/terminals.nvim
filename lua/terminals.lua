local M = {}
local state = {
	visible = false,
	list = {},
	active_idx = 1,
}

local win_config = {
	relative = "win",
	width = vim.o.columns,
	height = 10,
	row = vim.o.lines - 10,
	col = 0,
	border = "single",
	style = "minimal",
}

function M.show_term()
	local win = vim.api.nvim_open_win(state.list[state.active_idx].buf, true, win_config)
	state.list[state.active_idx].win = win
	state.visible = true
end

function M.show_prev()
	if state.active_idx > 1 then
		state.active_idx = state.active_idx - 1
		M.show_term()
	end
end

function M.show_next()
	if state.active_idx < #state.list then
		state.active_idx = state.active_idx + 1
		M.show_term()
	end
end

function M.hide_term()
	vim.api.nvim_win_hide(state.list[state.active_idx].win)
	state.visible = false
end

function M.create_new_term()
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, win_config)
	local item = { win = win, buf = buf }
	table.insert(state.list, item)
	state.active_idx = #state.list
	state.visible = true
	vim.cmd.terminal()
end

function M.toggle_term()
	if state.visible then
		M.hide_term()
	else
		M.show_term()
	end
end

function M.show_all() end

function M.go_back() end

function M.setup() end
return M
