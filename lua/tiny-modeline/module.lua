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

---@class Modneo.Modeline
---@field options Modneo.Modeline.Options
local M = {}

---appends the modeline as last line if not existing
---@param force boolean? append regarless of existing modeline(s)
M.append = function(force)
    -- don't append next modeline
    if not (force or false) and M.has_modeline then
        return
    end

    local lastlineno = vim.fn.line('$')
    local lastlinetext = vim.fn.getline(lastlineno)
    if string.len(lastlinetext) ~= 0 then
        lastlineno = lastlineno + 1
        vim.fn.setline(lastlineno, '')
    end
    vim.fn.append(lastlineno, M.modeline())
end

---replaces the existing modeline with current settings or adds a new one
M.update = function()
    if M.has_modeline() then
        vim.fn.setline(vim.fn.line('$'), M.modeline())
        return
    end
    -- pass true to bypass redudannt check
    M.append(true)
end

---@return boolean true of a modeline exists, otherwise false
---gets a value indicating if the file has a mode line
M.has_modeline = function()
    local last_line = vim.fn.getline(vim.fn.line('$'))
    local compare_str = vim.fn.substitute(vim.bo.commentstring, "%s", M.options.prefix, '')
    compare_str = string.sub(compare_str, 0, string.find(compare_str, ':', 2))
    return vim.startswith(last_line, compare_str)
end

---checks if a space can or shall be added
---@param config Modneo.Modeline.Options
---@return string either a space or an empty string
local function spacer(config)
    if config.style ~= 'set' then return '' end
    return (config.add_space and ' ' or '')
end

---@return string the modeline content
M.modeline = function()
    local separator = (M.options.style == 'set' and ' ' or M.options.separator)
    local content = M.options.prefix .. ':' .. spacer(M.options)

    if M.options.style == 'set' then
        content = content .. 'set '
    end
    for _, o in ipairs(M.options.include.flags) do
        content = content .. vim.fn.printf("%s%s%s", (vim.bo[o] and '' or 'no'), o, separator)
    end
    for _, o in ipairs(M.options.include.opts) do
        content = content .. vim.fn.printf("%s=%d%s", o, vim.bo[o], separator)
    end
    if not vim.endswith(content, ':') then
        content = vim.fn.substitute(content, "\\s$", "", "")
        content = content .. ":"
    end
    return vim.fn.substitute(vim.bo.commentstring, "%s", content, "")
end

---Applies the configuration and returns the module
---@return Modneo.Modeline
M.init = function()
    M.options = require('tiny-modeline.config').options
    return M
end

return M

-- vim: set et ts=4 sw=4 tw=78:
