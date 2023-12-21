local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sg', builtin.git_files, {})
vim.keymap.set('n', '<leader>sl', builtin.live_grep, {})
vim.keymap.set('v', '<leader>sl', function()
    local current_visual_selection = function()
        -- thanks to https://github.com/nvim-telescope/telescope.nvim/issues/1923#issuecomment-1122642431
        vim.cmd('noau normal! "vy"')
        local text = vim.fn.getreg('v')
        vim.fn.setreg('v', {})

        text = string.gsub(text, "\n", "")
        if #text > 0 then
            return text
        else
            return ''
        end
    end
    builtin.grep_string({
        default_text = current_visual_selection()
    })
end, {})
vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
vim.keymap.set('n', '<leader>sa', builtin.builtin, {})
vim.keymap.set('n', '<leader>sd', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>si', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>sr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>st', builtin.treesitter, {})
vim.keymap.set('n', '<leader>se', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>sle', function() builtin.diagnostics({ bufnr = 0 }) end, {})
vim.keymap.set('n', '<leader>sc', builtin.lsp_incoming_calls, {})
