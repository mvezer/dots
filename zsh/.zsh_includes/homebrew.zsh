#!/usr/bin/zsh

function enable_apps() {
  for app in "$@"; do
    if ! /usr/bin/xattr -l "$app" | grep -q '^com.apple.quarantine'; then
      echo "Enabling $app"
      xattr -d -r com.apple.quarantine "$app"
    fi
  done
}

apps_to_enable=(
  "/Applications/Alacritty.app"
  "/Applications/AeroSpace.app"
  "/Applications/Zen\ Browser.app"
)

alias "br"="HOMEBREW_NO_AUTO_UPDATE=1 brew bundle install --file=~/Brewfile --cleanup"
alias "bru"="brew bundle install --file=~/Brewfile --cleanup && enable_apps ${apps_to_enable[*]}"
