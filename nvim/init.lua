-- ======================================
--             Packer Setup
-- ======================================

-- Ensure packer is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- Plugins
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'reedes/vim-pencil'
  use 'tpope/vim-fugitive'
  use 'blazkowolf/gruber-darker.nvim'
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'ap/vim-css-color'
  use 'ledger/vim-ledger'
  use 'hoob3rt/lualine.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use { 'andweeb/presence.nvim', requires = { 'nvim-tree/nvim-web-devicons', }, }
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- ======================================
--             Keybindings
-- ======================================

-- Map Ctrl+S to :w (save) in insert mode
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

-- Map Ctrl+Backspace to kill the word backward
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "<C-BS>", "<C-w>", { noremap = true, silent = true })

-- Set tab size to 4 spaces
vim.o.tabstop = 2      -- Number of spaces a tab counts for
vim.o.shiftwidth = 2   -- Number of spaces to use for autoindent
vim.o.expandtab = true -- Convert tabs to spaces

-- ======================================
--             Colorscheme
-- ======================================

vim.opt.termguicolors = true
vim.cmd.colorscheme("gruber-darker")

-- ======================================
--             General Settings
-- ======================================

vim.opt.scrolloff = 7
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.showtabline = 2
vim.opt.guicursor = ''
vim.opt.clipboard:append('unnamedplus')

-- ======================================
--             Keybindings
-- ======================================

-- Leader key
vim.g.mapleader = ','

-- Telescope keybindings
local map = vim.api.nvim_set_keymap
map('n', '<leader>ff', "<cmd>Telescope find_files<cr>", { noremap = true })
map('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", { noremap = true })
map('n', '<leader>fb', "<cmd>Telescope buffers<cr>", { noremap = true })
map('n', '<leader>fd', "<cmd>Telescope file_browser<cr>", { noremap = true })

-- Switch between buffers
map('n', '<C-N>', ':bn<CR>', { noremap = true })
map('n', '<C-P>', ':bp<CR>', { noremap = true })

-- ======================================
--             Plugin Configurations
-- ======================================

require("gruber-darker").setup({
  bold = true,       -- Disable bold text
  italic = true,      -- Enable italics
  underline = false,  -- Disable underlines
  contrast = "medium"   -- Options: "soft", "medium", "hard"
})

-- Vim-pencil configuration
vim.g['pencil#wrapModeDefault'] = 'soft'
vim.api.nvim_exec([[
  augroup pencil
    autocmd!
    autocmd FileType markdown,mkd,gmi call pencil#init()
    autocmd FileType text call pencil#init({'wrap': 'hard'})
  augroup END
]], false)

-- ======================================
--             lualine
-- ======================================

require('lualine').setup {
  options = {
    icons_enabled = true,
    component_separators = {'|', '|'},
    section_separators = {'', ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filetype'},
    lualine_x = {'encoding', 'fileformat'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {'filename'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
}

-- ======================================
--             Treesitter
-- ======================================

require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  indent = { enable = true },
}

-- ======================================
--             Telescope
-- ======================================

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=always',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "❯ ",
    selection_caret = "➜ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
        prompt_position = 'bottom',
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' },
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

-- ================================
--           Nvim-Tree
-- ================================
require'nvim-tree'.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    respect_buf_cwd = true,
    renderer = {
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
            },
        },
    },
}
-- Keymapping for toggling Nvim Tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "<C-BS>", "<C-w>", { noremap = true, silent = true })

-- ==================================
--           Discord RPC
-- ==================================
-- The setup config table shows all available config options with their default values:
require("presence").setup({
    -- General options
    auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
    client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                      -- Displays the current line number instead of the current project
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                       -- Show the timer

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})
