return {
  "lervag/vimtex",
  lazy = false,
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    vim.g.vimtex_view_method = "zathura"
    -- Set vimtex to use latexmk for compilation
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "",
      options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
    }
  end,
}
