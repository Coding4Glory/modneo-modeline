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
        local opts = (M.options.honor_existing and M.parse() or {})
        vim.fn.setline(vim.fn.line('$'), M.modeline(opts))
        return
    end
    -- pass true to bypass redudannt check
    M.append(true)
end

---@return boolean true of a modeline exists, otherwise false
---gets a value indicating if the file has a mode line
M.has_modeline = function()
    local last_line = vim.fn.getline(vim.fn.line('$'))
    local has_modeline = false
    for _, p in ipairs({'ex', 'vi', 'vim'}) do
        local compare_str = vim.fn.substitute(vim.bo.commentstring, "%s", p, '')
        compare_str = string.sub(compare_str, 0, string.find(compare_str, ':', 2))
        has_modeline = has_modeline or vim.startswith(last_line, compare_str)
    end
    return has_modeline
end

---Parses the given line, if no line is given the last line in the buffer is
---parsed.
---@param line string?
---@return Modneo.Modeline.Options
M.parse = function(line)
    local function separator_by_count(line)
        local colon, space = 0, 0
        for x in line:gmatch('[:%s]') do
            if x == ':' then colon = colon + 1
            else
                space = space + 1
            end
        end
        return (colon > space and ':' or ' ')
    end

    line = line or vim.fn.getline(vim.fn.line('$'))
    line = line:match(string.format(vim.bo.commentstring, '(.*)'))
    local result = { include = { opts = {}, flags = {} } }
    result.prefix = line:match('([^:]+).*')
    result.style = line:match(result.prefix .. '[:%s]+(set)[:%s]') or 'separated'
    result.separator = separator_by_count(line)
    for o in line:gmatch('(%w+)=') do
        table.insert(result.include.opts, o)
    end
    line, _ = line:gsub('[:%s]%w+=[^:%s]*', '')
    for f in line:gmatch('[:%s]n?o?(%w+)') do
        if f ~= 'set' then
            table.insert(result.include.flags, f)
        end
    end
    return result
end

---checks if a space can or shall be added
---@param config Modneo.Modeline.Options
---@return string either a space or an empty string
local function spacer(config)
    if config.style ~= 'set' then return '' end
    return (config.add_space and ' ' or '')
end

---creates and returns the modeline string
---@param opts Modneo.Modeline.Options? options may be passed to override settings
---@return string the modeline content
M.modeline = function(opts)
    local options = opts or M.options
    local separator = (options.style == 'set' and ' ' or options.separator)
    local content = options.prefix .. ':' .. spacer(options)

    if options.style == 'set' then
        content = content .. 'set '
    end
    for _, o in ipairs(options.include.flags) do
        content = content .. string.format("%s%s%s", (vim.bo[o] and '' or 'no'), o, separator)
    end
    for _, o in ipairs(options.include.opts) do
        content = content .. string.format("%s=%d%s", o, vim.bo[o], separator)
    end
    if not vim.endswith(content, ':') then
        content = vim.fn.substitute(content, "\\s$", "", "")
        content = content .. ":"
    end
    local format = vim.bo.commentstring ~= "" and vim.bo.commentstring or "%s"
    return string.format(format, content)
end

---Applies the configuration and returns the module
---@return Modneo.Modeline
M.init = function()
    M.options = require('modneo-modeline.config').options
    return M
end

return M

-- vim: set et ts=4 sw=4 tw=78: