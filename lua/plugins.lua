---@diagnostic disable: undefined-global
--在没有安装packer的电脑上，自动安装packer插件
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  --fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})	--默认地址
  fn.system(
    {"git", "clone", "--depth", "1", "https://codechina.csdn.net/mirrors/wbthomason/packer.nvim.git", install_path}
  ) --csdn加速镜像
  vim.cmd "packadd packer.nvim"
end
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require("packer").startup(
  {
    function()
      use "wbthomason/packer.nvim"
      -- Packer can manage itself

      --- aiarline
      use {
        "vim-airline/vim-airline",
        requires = {
          "vim-airline/vim-airline-themes",
          --综合图标支持such vim-airline lightline, vim-startify
          "ryanoasis/vim-devicons"
        }
      }
      ---主题
      use "sainnhe/gruvbox-material"
      use "mhartington/oceanic-next"

      ---ranger插件
      use "kevinhwang91/rnvimr"

      ---文件树
      use {
        "Shougo/defx.nvim",
        requires = {
          "kristijanhusak/defx-icons", -- dexf文件管理图标支持
          "t9md/vim-choosewin" -- 窗口选择器,可以让defx使用i打开文件
        }
      }

      --Nvim LSP 客户端的快速入门配置
      use "neovim/nvim-lspconfig"
      use {
        "hrsh7th/nvim-cmp",
        requires = {
          "hrsh7th/cmp-nvim-lsp", --neovim 内置 LSP 客户端的 nvim-cmp 源
          --以下插件可选，可以根据个人喜好删减
          "onsails/lspkind-nvim", --美化自动完成提示信息
          "hrsh7th/cmp-buffer", --从buffer中智能提示
          "hrsh7th/cmp-nvim-lua", --nvim-cmp source for neovim Lua API.
          "octaltree/cmp-look", --用于完成英语单词
          "hrsh7th/cmp-path", --自动提示硬盘上的文件
          "hrsh7th/cmp-calc", --输入数学算式（如1+1=）自动计算
          "f3fora/cmp-spell", --nvim-cmp 的拼写源基于 vim 的拼写建议
          "hrsh7th/cmp-emoji" --输入: 可以显示表情
        }
      }

      --[[
         [-- 代码段提示
         [use {
         [  "L3MON4D3/LuaSnip",
         [  requires = {
         [    "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
         [    "rafamadriz/friendly-snippets" --代码段合集
         [  }
         [}
		 ]]
      use {
        "SirVer/ultisnips", -- 代码段
        requires = {
          "quangnguyen30192/cmp-nvim-ultisnips", -- for nvim-cmp
          "honza/vim-snippets", -- 代码段集合
          config = function()
            require("cmp_nvim_ultisnips").setup {}
          end
        }
      }

      --代码格式化工具，主要用于lua语法格式化
      use "mhartington/formatter.nvim"

      --markdown预览
      use "iamcco/markdown-preview.nvim"

      --lsp自动安装
      use {
        --'neovim/nvim-lspconfig',
        "williamboman/nvim-lsp-installer"
      }

      --coc.nvim
      --use {"neoclide/coc.nvim", branch = "release"}
      --[[use {"neoclide/coc.nvim", branch = "master", run = "yarn install --frozen-lockfile"}]]
      -- 错误检测
      -- use "dense-analysis/ale"

      --latex预览
      use "lervag/vimtex"

      --快速注释
      use "preservim/nerdcommenter"

      --括号颜色
      use "luochen1990/rainbow"

      --成对括号
      use "jiangmiao/auto-pairs"

      -- 自动为尚不支持 Neovim 0.5 内置 lsp 客户端的配色方案创建缺少的 LSP 诊断突出显示组。
      use "folke/lsp-colors.nvim"
      -- 基于neovim 内置lsp 的轻量级lsp 插件，具有高性能UI。非常酷
      -- use {'glepnir/lspsaga.nvim', branch= 'main' }
      -- use "rinx/lspsaga.nvim"
      use {"tami5/lspsaga.nvim"}

      use "quangnguyen30192/cmp-nvim-ultisnips"

      -- 文件搜索 预览 等
      use {
        "nvim-telescope/telescope.nvim",
        requires = {
          "nvim-lua/plenary.nvim",
          "kyazdani42/nvim-web-devicons"
        }
      }
      -- 加速文件搜索速度,如果安装失败需要到插件目录执行make命令手动编译
      -- 用了这个插件以后，貌似更快了(感觉输入更跟手了，可能是心理作用)。但是对于我的小项目感受不是很明显
      use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
      use {"fhill2/telescope-ultisnips.nvim"}
      use {"xiyaowong/telescope-emoji.nvim"}

      --高性能代码高亮插件
      use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
      }

      --spell check
      use {"lewis6991/spellsitter.nvim"}

      -- debug
      use "puremourning/vimspector"

      use "chr4/nginx.vim"

      use {"kaicataldo/material.vim", branch = "main"}

      use "rakr/vim-one"

      -- 异步执行shell
      use "skywind3000/asyncrun.vim"
      use {"skywind3000/asynctasks.vim"}

      use "nanotee/sqls.nvim"

      --use "xolox/vim-misc"
      --use "https://git.oschina.net/iamdsy/vim-lua-ftplugin"

      -- for jsonls
      use "b0o/schemastore.nvim"

	  use("nathom/filetype.nvim")
    end,
    config = {
      max_jobs = 16,
      git = {
        default_url_format = "https://github.com/%s"
      },
      display = {
        open_fn = function()
          return require("packer.util").float({border = "single"})
        end
      }
    }
  }
)
