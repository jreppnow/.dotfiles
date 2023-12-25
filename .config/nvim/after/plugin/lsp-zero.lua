local lsp = require("lsp-zero")

lsp.preset(
    {
        float_border = 'rounded',
        call_servers = 'local',
        configure_diagnostics = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = {
            preserve_mappings = false,
            omit = {},
        },
        manage_nvim_cmp = {
            set_sources = 'recommended',
            set_basic_mappings = true,
            set_extra_mappings = false,
            use_luasnip = true,
            set_format = true,
            documentation_window = true,
        },
    }
)

lsp.ensure_installed({ 'tsserver', 'rust_analyzer', 'clangd' })
lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local function set_keybinds(_, bufnr)
    print("LSP attached, setting keybinds..!")

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>ge", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>gpe", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ra", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>sr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end


lsp.on_attach(set_keybinds)

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
    }
})

lsp.nvim_lua_ls()

lsp.setup()

require('mason-lspconfig').setup({
    handlers = {
        lsp.default_setup,
        rust_analyzer = function()
            require('lspconfig').rust_analyzer.setup({
                settings = {
                    ["rust-analyzer"] = {
                        procMacro = {
                            enable = true,
                        },
                        checkOnSave = {
                            command = "clippy"
                        }
                    }
                },
                on_attach = function(n, bufnr)
                    print("Enabling custom functions for Rust!")
                    set_keybinds(n, bufnr)
                end
            })
        end,
    }
})

vim.diagnostic.config({
    virtual_text = true
})
