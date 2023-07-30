function ColorMyStuff()
    vim.opt.background = 'dark'
    vim.cmd.colorscheme('PaperColor')
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = nil, bold = true })
    vim.api.nvim_set_hl(0, "Normal", { bg = nil })
end

ColorMyStuff()
