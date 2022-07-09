require("spellsitter").setup {
  enable = true
}

-- this is a comment with a baad word

require "nvim-treesitter.configs".setup {
  highlight = {
    enable = true
    -- additional_vim_regex_highlighting = true, -- DO NOT SET THIS
  }
}
