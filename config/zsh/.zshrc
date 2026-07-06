# Use XDG dirs
[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh

# Source files
[ -f "$ZDOTDIR/aliases" ] && source "$ZDOTDIR/aliases"

# Load modules
zmodload zsh/complist
autoload -U colors && colors

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
autoload -U compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# History
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTCONTROL=ignoreboth

# Disable vi binds
bindkey -e

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Fzf
source <(fzf --zsh)

# Zoxide
eval "$(zoxide init zsh)"

# Mise
eval "$(mise activate zsh)"

# Zsh plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship
eval "$(starship init zsh)"
