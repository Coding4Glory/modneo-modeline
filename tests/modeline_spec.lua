local defaults = require('tiny-modeline.config').init()
-- require('plenary.busted') -- not required but nice for auto completion

local function get_test_buffer()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(buf)
    vim.bo.commentstring = '-- %s'
    vim.bo.ts = 4
    vim.bo.sw = 4
    vim.bo.tw = 80
    vim.bo.et = true
    return buf
end

describe('modeline', function()
    it('creates the default modeline', function()
        local module = require('tiny-modeline.module').setup(defaults)

        local test_buf = get_test_buffer()
        vim.api.nvim_buf_call(test_buf, function()
            local compare_line = '-- vim: set et ts=4 sw=4 tw=80:'
            assert(module.modeline() == compare_line, '"' .. compare_line .. '" not equal "' .. module.modeline() .. '"')
        end)
    end)
end)
