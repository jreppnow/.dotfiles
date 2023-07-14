function color_my_stuff()
    vim.opt.background = 'dark'
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "DarkGray", bold = true })
    vim.cmd.colorscheme('PaperColor')
    vim.api.nvim_set_hl(0, "Normal", { bg = "Black" })
end

color_my_stuff()
