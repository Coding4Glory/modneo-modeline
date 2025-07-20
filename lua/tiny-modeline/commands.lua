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

---@class TinyModelineCommands
local M = {}

---Creates the user commands and default key bindings
---@param modeline TinyModelineModule
M.setup = function(modeline)
    vim.api.nvim_create_user_command('ModelineAppend', function(opts)
        modeline.append(opts.bang)
    end, { desc = 'appends a new modeline regardless of existing', bang = true })

    vim.api.nvim_create_user_command('ModelineUpdate', function(opts)
        modeline.update()
    end, { desc = 'Updates the current modeline or appends a new one' })

    vim.api.nvim_create_user_command('ModelinePresent', function(opts)
        if modeline.has_modeline() then
            print('modeline is present')
        else
            print('modeline is missing')
        end
    end, { desc = 'checks if modeline is present' })

    if modeline.config.add_default_keybindings then
        local function add_keymap(keys, cmd, desc)
            vim.api.nvim_set_keymap('n', keys, cmd, { noremap = true, silent = true, desc = desc })
        end

        add_keymap('<leader>mu', ':ModelineUpdate<CR>', 'modeline update')
    end

    if modeline.config.update_on_write then
        vim.api.nvim_create_autocmd("BufWrite",
            {
                pattern = '*.*',
                command = 'ModelineUpdate',
                desc = 'update modline on write',
                group = vim.api.nvim_create_augroup('tinymodeline_autoupdate', { clear = true })
            }
        )
    end
end

return M

-- vim: set et ts=4 sw=4 tw=0:
