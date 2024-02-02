---
--- bubbles
---
-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'o:encoding', 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}


---
--- barbar
---

vim.g.barbar_auto_setup = false -- disable auto-setup

require('barbar').setup {
  -- WARN: do not copy everything below into your config!
  --       It is just an example of what configuration options there are.
  --       The defaults are suitable for most people.

  -- Enable/disable animations
  animation = true,

  -- Automatically hide the tabline when there are this many buffers left.
  -- Set to any value >=0 to enable.
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  exclude_ft = {'javascript'},
  exclude_name = {'package.json'},

  -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
  -- Valid options are 'left' (the default), 'previous', and 'right'
  focus_on_close = 'left',

  -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
  hide = {extensions = true, inactive = true},

  -- Disable highlighting alternate buffers
  highlight_alternate = false,

  -- Disable highlighting file icons in inactive buffers
  highlight_inactive_file_icons = false,

  -- Enable highlighting visible buffers
  highlight_visible = true,

  icons = {
    -- Configure the base icons on the bufferline.
    -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
    buffer_index = false,
    buffer_number = false,
    button = '',
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
      [vim.diagnostic.severity.WARN] = {enabled = false},
      [vim.diagnostic.severity.INFO] = {enabled = false},
      [vim.diagnostic.severity.HINT] = {enabled = true},
    },
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '~'},
      deleted = {enabled = true, icon = '-'},
    },
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = false,

      -- Requires `nvim-web-devicons` if `true`
      enabled = true,
    },
    separator = {left = '▎', right = ''},

    -- If true, add an additional separator at the end of the buffer list
    separator_at_end = true,

    -- Configure the icons on the bufferline when modified or pinned.
    -- Supports all the base icon options.
    modified = {button = '●'},
    pinned = {button = '', filename = true},

    -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
    preset = 'default',

    -- Configure the icons on the bufferline based on the visibility of a buffer.
    -- Supports all the base icon options, plus `modified` and `pinned`.
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = true},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
  },

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the minimum padding width with which to surround each tab
  minimum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- Sets the minimum buffer name length.
  minimum_length = 0,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    -- Use the default values: {event = 'BufWinLeave', text = nil}
    NvimTree = true,
    -- Or, specify the text used for the offset:
    undotree = {text = 'undotree'},
    -- Or, specify the event which the sidebar executes when leaving:
    ['neo-tree'] = {event = 'BufWipeout'},
    -- Or, specify both
    Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
  },

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustment
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}


---
--- neo-tree
---
vim.fn.sign_define("DiagnosticSignError",
  {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn",
  {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo",
  {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",
  {text = "󰌵", texthl = "DiagnosticSignHint"})

require("neo-tree").setup({
  close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  sort_function = nil , -- use a custom function for sorting files and directories in the tree 
  -- sort_function = function (a,b)
  --       if a.type == b.type then
  --           return a.path > b.path
  --       else
  --           return a.type > b.type
  --       end
  --   end , -- this sorts files and directories descendantly
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "󰜌",
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted   = "✖",-- this can only be used in the git_status source
        renamed   = "󰁕",-- this can only be used in the git_status source
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "󰄱",
        staged    = "",
        conflict  = "",
      }
    },
    -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
    file_size = {
      enabled = true,
      required_width = 64, -- min width of window required to show this column
    },
    type = {
      enabled = true,
      required_width = 122, -- min width of window required to show this column
    },
    last_modified = {
      enabled = true,
      required_width = 88, -- min width of window required to show this column
    },
    created = {
      enabled = true,
      required_width = 110, -- min width of window required to show this column
    },
    symlink_target = {
      enabled = false,
    },
  },
  -- A list of functions, each representing a global custom command
  -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
  -- see `:h neo-tree-custom-commands-global`
  commands = {},
  window = {
    position = "left",
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = { 
          "toggle_node", 
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel", -- close preview or floating neo-tree window
      ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
      -- Read `# Preview Mode` for more information
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ["w"] = "open_with_window_picker",
      --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
      ["C"] = "close_node",
      -- ['C'] = 'close_all_subnodes',
      ["z"] = "close_all_nodes",
      --["Z"] = "expand_all_nodes",
      ["a"] = { 
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none" -- "none", "relative", "absolute"
        }
      },
      ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
      ["i"] = "show_file_details",
    }
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_hidden = true, -- only works on Windows for hidden files/directories
      hide_by_name = {
        --"node_modules"
      },
      hide_by_pattern = { -- uses glob style patterns
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
    follow_current_file = {
      enabled = false, -- This will find and focus the file in the active buffer every time
      --               -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                            -- in whatever position is specified in window.position
                          -- "open_current",  -- netrw disabled, opening a directory opens within the
                                            -- window like netrw would, regardless of window.position
                          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                    -- instead of relying on nvim autocmd events.
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["og"] = { "order_by_git_status", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
      },
    },

    commands = {} -- Add a custom command or override a global one using the same function name
  },
  buffers = {
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --              -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = true, -- when true, empty folders will be grouped together
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
      }
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"]  = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
        ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
      }
    }
  }
})

vim.cmd([[nnoremap <C-d> :Neotree toggle=true<cr>]])

---
--- tokyonight
---
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "Night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})
