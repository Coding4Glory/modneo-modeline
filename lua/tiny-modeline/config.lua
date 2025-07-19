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
local defaults = {
    ---@type string
    ---the modeline style, can be separated (first form from help) and set (second form from help)
	style = 'set',
    ---@type string
    ---the separator to use, either blank `' '` or colon `":"`. Default: blank
	separator = ' ',
    ---@type string
    ---prefix string the prefix to use for the modeline, one of vi, vim or ex. Default: vim
	prefix = 'vim',
    ---@class TinyModelineSettings.include
    ---a table with opts and flags to include
	include = {
        ---@type table
        ---the list of options to include, use short forms
        opts = {
	    	'ts',
    		'sw',
            'tw',
        },
        ---@type table
        ---the list of flags to add, use short forms
        flags = {
            'et',
        }
	},
    ---@type boolean
    ---add optional spaces where possible, Default: true
	add_space = true,
    ---@type boolean
    ---boolean Whether to add default keybindings. Default: true
    add_default_keybindings = true,
}

---@type TinyModelineSettings
M.config = defaults

---@type function
---initializes the configuration and applies usersettings
---@param args TinyModelineSettings?
---@return TinyModelineSettings
M.init = function(args)
    M.config = vim.tbl_deep_extend('force', M.config, args or {})
    return M.config
end

return M

-- vim: set et ts=4 sw=4 tw=0:
