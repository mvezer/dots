return {
  files = {
    rg_opts = [[--color=never --hidden --files -g "!.git"]],
    fd_opts = [[--color=never --hidden --type f --type l --exclude .git]],
  },
  grep = {
    hidden = true,
  },
  winopts = {
    width = 1.0,
    height = 1.0,
  }
}
