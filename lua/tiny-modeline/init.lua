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

---@class Modneo.ModelinePlugin
return {
    ---initializes the module
    ---@param opts Modneo.Modeline.Options
    setup = function(opts)
        local config = require('tiny-modeline.config').setup(opts)
        local modeline = require('tiny-modeline.module').init()
        require('tiny-modeline.commands').setup(modeline)
    end,
}

-- vim: set et ts=4 sw=4 tw=78:
