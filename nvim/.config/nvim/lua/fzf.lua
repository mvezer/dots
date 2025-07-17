return {
  files = {
    rg_opts = [[--color=never --hidden --files -g "!.git"]],
    fd_opts = [[--color=never --hidden --type f --type l --exclude .git]],
  },
  buffers = {
    fzf_opts = { ["--delimiter"] = "/", ["--with-nth"] = "-3..-1" },
  },
  grep = {
    hidden = true,
  },
  winopts = {
    width = 1.0,
    height = 1.0,
  },
}
