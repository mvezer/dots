typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# path
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH="$VOLTA_HOME/bin:$PATH"
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

zinit ice depth=1; zinit light romkatv/powerlevel10k
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
zmodload zsh/zprof
eval "$(zoxide init --cmd cd zsh)"
# aliases
alias ll="exa --icons -al --time-style=long-iso --git --no-user --no-permissions"
alias l="exa --icons -al --time-style=long-iso --git --no-user --no-permissions"
alias t="tmux attach -t default || tmux new -s default"
alias tree="exa -al -T --no-time --no-user --no-permissions -I node_modules $argv"
alias ws="cd $WORKSPACE"
alias cfg="cd ~/.config"
alias nxt="cd $WORKSPACE/next-level"
alias zsrc="source ~/.zshrc"
alias "nv"="nvim"
if [[ "$OS" = "Linux" ]]; then
  alias cb="xclip -selection c"
else
  alias cb="pbcopy"
fi

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
source $ZSH_INCLUDES/git.zsh
source $ZSH_INCLUDES/go.zsh
source $ZSH_INCLUDES/zig.zsh

# misc settings
unsetopt BEEP
