function color_my_stuff() 
	vim.opt.background = 'dark'
	vim.cmd.colorscheme('PaperColor')
	vim.api.nvim_set_hl(0, "Normal", { bg=Black })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg=Black })
end

color_my_stuff()
