# starship prompt
eval "$(starship init zsh)"
# env vars
export SECRETS="$HOME/.secrets"
export EDITOR="nvim"
export ZSH_INCLUDES="$HOME/.zsh_includes"
export WORKSPACE="$HOME/workspace"
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# misc settings
unsetopt BEEP

# history
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILESIZE=10000
export HISTIGNORE="&:ls:[bf]g:exit"
export HISTTIMEFORMAT="%F %T "
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# path
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.npm-packages"
export PATH="$PATH:$HOME/go/bin"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# zinit
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

zmodload zsh/zprof
eval "$(zoxide init --cmd cd zsh)"

# aliases
alias ll="eza --icons -al --time-style=long-iso --git --no-user --no-permissions"
alias l="eza --icons -al --time-style=long-iso --git --no-user --no-permissions"
alias tree="eza -al -T --no-time --no-user --no-permissions -I node_modules $argv"
alias ws="cd $WORKSPACE"
alias zsrc="source ~/.zshrc"
alias "nv"="nvim"
function v() {
  local dst="$(command vifm --choose-dir - "$@")"
  if [ -z "$dst" ]; then
    echo 'Directory picking cancelled/failed'
    return 1
  fi
  cd "$dst"
}

# clipboard
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias cb="pbcopy"
else
  alias battery="cat /sys/class/power_supply/BAT0/capacity"
  alias cb="xclip -selection c"
fi

# source machine-specific secrets
if [ -f $SECRETS ]; then source $SECRETS; fi

# source ZSH config
if [[ "$OSTYPE" == "darwin"* ]]; then
  source $ZSH_INCLUDES/homebrew.zsh
fi
if [[ "$HOST" == "rocinante" ]]; then # work laptop
  source $ZSH_INCLUDES/promaton.zsh
fi
source $ZSH_INCLUDES/zk.zsh
source $ZSH_INCLUDES/general.zsh
source $ZSH_INCLUDES/kubernetes.zsh
source $ZSH_INCLUDES/tmux.zsh
source $ZSH_INCLUDES/git.zsh
source $ZSH_INCLUDES/go.zsh
source $ZSH_INCLUDES/zig.zsh
source $ZSH_INCLUDES/aws.zsh
source $ZSH_INCLUDES/lua.zsh


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

