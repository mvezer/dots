# starship prompt
eval "$(starship init zsh)"
# env vars
export SECRETS="$HOME/.secrets"
export EDITOR="nvim"
export ZSH_INCLUDES="$HOME/.zsh_includes"
export WORKSPACE="$HOME/workspace"
export VOLTA_HOME="$HOME/.volta"
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
export OS="$(uname -s)"
if [[ "$OS"=="Linux" && -n $(uname -r | grep WSL) ]]; then
  OS="WSL"
fi

export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.npm-packages"
export PATH="$PATH:$HOME/go/bin"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
if [[ "$OS"=="Linux" ]]; then
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
fi

# mac brew
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
# linux brew
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]] then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
export HOMEBREW_BREWFILE="$HOME/.brew/Brewfile"
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

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
if [[ "$OS" = "Linux" ]]; then
  alias cb="xclip -selection c"
else
  alias cb="pbcopy"
fi
alias vpn="sudo wg-quick up wg0"
alias vpn-prod="sudo wg-quick up wg1"
alias itter="ssh just_passing_by@app.itter.sh"


function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd "$cwd"
	fi
	rm -f -- "$tmp"
}

# source machine-specific secrets
if [ -f $SECRETS ]; then source $SECRETS; fi

# source ZSH config
source $ZSH_INCLUDES/general.zsh
source $ZSH_INCLUDES/kubernetes.zsh
source $ZSH_INCLUDES/tmux.zsh
source $ZSH_INCLUDES/git.zsh
source $ZSH_INCLUDES/go.zsh
source $ZSH_INCLUDES/zig.zsh
source $ZSH_INCLUDES/aws.zsh
source $ZSH_INCLUDES/lua.zsh

source $(brew --prefix)/share/zsh/site-functions/_todoist_fzf

# misc settings
unsetopt BEEP

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/matyas.vezer/.lmstudio/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


