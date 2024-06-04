require('telescope').setup({
    defaults = {
        layout_strategy='vertical'
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            ignore_current_buffer = true,
        }
    },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
