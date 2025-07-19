--[[
tiny-modeline.nvim
Copyright (C) 2025  Markus Hergenröder <markus@coding4glory.net>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]--

---@class TinyModelineConfig
local M = {}

---@class TinyModelineSettings
---@style the modeline style, can be separated (first form from help) and set (second form from help)
---@field prefix string the prefix to use for the modeline, one of vi, vim or ex. Default: vim
---@field include table table with all opts and flags to include
---@field separator string the separator to use, either blank `' '` or colon `":"`. Default: blank
---@field add_default_keybindings boolean Whether to add default keybindings. Default: true
local defaults = {
	style = 'set',
	separator = ' ',
	prefix = 'vim',
	include = {
        opts = {
	    	'ts',
    		'sw',
            'tw',
        },
        flags = {
            'et',
        }
	},
	add_space = true,
    add_default_keybindings = true,
}

---@type TinyModelineSettings
M.config = defaults

---@param args TinyModelineSettings?
---@return TinyModelineSettings
M.init = function(args)
    M.config = vim.tbl_deep_extend('force', M.config, args or {})
    return M.config
end

return M

-- vim: set et ts=4 sw=4 tw=0:
