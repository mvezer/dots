return function ()
  require("nvim-rooter").setup({
    rooter_patterns = { 'package.json', '.git' },
    trigger_patterns = { '*' },
    manual = false,
    fallback_to_parent = false,
    cd_scope = "global",
  })
  
end
