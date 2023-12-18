vim.opt.clipboard = "unnamedplus" 
vim.opt.number = true 
vim.opt.relativenumber = true 
vim.opt.mouse = "a"
vim.g.mapleader = " "
vim.opt.tabstop = 4

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	  vim.fn.system({
		      "git",
		          "clone",
			      "--filter=blob:none",
			          "https://github.com/folke/lazy.nvim.git",
				      "--branch=stable", -- latest stable release
				          lazypath,
					    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{"catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
    		'nvim-telescope/telescope.nvim', tag = '0.1.5',
      		dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", 
      "MunifTanjim/nui.nvim",
    }
    }
}
local opts = {}

require("lazy").setup(plugins, opt)
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>t', ':Neotree toggle<CR>', {})
vim.keymap.set('n', '<leader>tf', ':Neotree action=focus<CR>', {})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript", "python", "java", "c"},
  highlight = { enable = true },
  indent = { enable = true },  
})

require("catppuccin").setup() 
vim.cmd.colorscheme "catppuccin"
