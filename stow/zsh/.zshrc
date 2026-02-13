# FZF
source <(fzf --zsh)

# Key bindings
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^Y' fzf-history-widget

# Environment
export EDITOR=nvim
export BAT_THEME=OneHalfDark
export TERM=xterm-256color

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$PATH:$HOME/.rd/bin"

# libpq (PostgreSQL)
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

# Tools
eval "$(fnm env --use-on-cd --shell zsh)"

# Aliases
alias v="nvim"
alias n="nvim"
alias vim="nvim"
alias dns="grep nameserver <(scutil --dns)"
