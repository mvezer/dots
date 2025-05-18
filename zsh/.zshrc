# starship prompt
eval "$(starship init zsh)"
# env vars
export SECRETS="$HOME/.secrets"
export EDITOR="nvim"
export ZSH_INCLUDES="$HOME/.zsh_includes"
export WORKSPACE="$HOME/workspace"
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

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
zinit light Aloxaf/fzf-tab
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

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

# clipboard
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias cb="pbcopy"
else
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

# misc settings
unsetopt BEEP

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


