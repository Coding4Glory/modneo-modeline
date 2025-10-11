local module = require("modneo-modeline.module")
-- require('plenary.busted') -- not required but nice for auto completion

local function get_test_buffer()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(buf)
    vim.bo.commentstring = "-- %s"
    vim.bo.ts = 4
    vim.bo.sw = 4
    vim.bo.tw = 80
    vim.bo.et = true
    return buf
end



describe("modeline", function()
    it("creates the default modeline", function()
        require("modneo-modeline.config").setup()
        local test_buf = get_test_buffer()
        vim.api.nvim_buf_call(test_buf, function()
            local compare_line = "-- vim: set et ts=4 sw=4 tw=80:"
            local sut = module.init()
            assert(sut.modeline() == compare_line, '"' .. compare_line .. '" not equal "' .. module.modeline() .. '"')
        end)
    end)

    it("creates a custom modeline", function()
        local config = { include = { opts = { "sts" }, flags = { "ai" } } }
        require("modneo-modeline.config").setup(config)

        local test_buf = get_test_buffer()
        vim.api.nvim_buf_call(test_buf, function()
            local compare_line = "-- vim: set ai sts=0:"
            local sut = module.init()
            assert(sut.modeline() == compare_line, '"' .. compare_line .. '" not equal "' .. module.modeline() .. '"')
        end)
    end)

    it("creates the other style", function()
        local config = { style = "separated", separator = ":" }
        require("modneo-modeline.config").setup(config)

        local test_buf = get_test_buffer()
        vim.api.nvim_buf_call(test_buf, function()
            local compare_line = "-- vim:et:ts=4:sw=4:tw=80:"
            local sut = module.init()
            assert(sut.modeline() == compare_line, '"' .. compare_line .. '" not equal "' .. module.modeline() .. '"')
        end)
    end)

    it("create no modeline", function()
        require("modneo-modeline").setup({})
        local test_buf = get_test_buffer()
        local empty = vim.fn.getline(1, '$')
        vim.bo.commentstring = ""
        vim.cmd("ModelineUpdate")
        assert.same(empty, vim.fn.getline(1, '$'))
    end)
end)
