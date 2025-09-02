--[[
modneo-modeline
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

---@alias Modneo.Modeline.Separator
---| ' ' a regular space aka blank
---| ':' a regular colon

---@alias Modneo.Modeline.Style
---| 'separated' first style from help
---| 'set' second style from help

---@alias Modneo.Modeline.Prefix
---| 'ex'
---| 'vi'
---| 'vim'

---@class Modneo.Modeline.Config
---@field options Modneo.Modeline.Options
local M = {}

---@class Modneo.Modeline.Options
local defaults = {
    ---@type Modneo.Modeline.Style
    ---the modeline style, can be separated (first form from help) and set (second form from help)
	style = 'set',
    ---@type Modneo.Modeline.Separator
    ---the separator to use, either blank `' '` or colon `":"`. Default: blank
	separator = ' ',
    ---@type Modneo.Modeline.Prefix
    ---prefix string the prefix to use for the modeline, one of vi, vim or ex. Default: vim
	prefix = 'vim',
    ---@class Modneo.Modeline.Options.Include
    ---a table with opts and flags to include
	include = {
        ---@type string[]
        ---the list of options to include, use short forms
        opts = {
	    	'ts',
    		'sw',
            'tw',
        },
        ---@type string[]
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
    ---@type boolean
    ---defines if the modeline shall be automatically updated on save
    ---Default: false
    update_on_write = false,
}

---@type function
---initializes the configuration and applies usersettings
---@param args Modneo.Modeline.Options?
---@return Modneo.Modeline.Options
M.setup = function(args)
    M.options = vim.tbl_deep_extend('force', defaults, args or {})
    return M.options
end

return M

-- vim: set et ts=4 sw=4 tw=78:
