# Path to your oh-my-zsh installation.
export ZSH="/Users/tripproberts/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="clean"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tripproberts/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/tripproberts/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tripproberts/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/tripproberts/google-cloud-sdk/completion.zsh.inc'; fi

# Load amplify environment
amplify_env () {
    PROJECT_DIR=$(git rev-parse --show-toplevel 2>/dev/null) 

    ENV=$PROJECT_DIR/amplify/.config/local-env-info.json 

    if [ -f "$ENV" ]; then
        env_info=$(cat $ENV | jq -r ".envName") 
        echo "($env_info)"
    fi
}

# bun completions
[ -s "/Users/tripproberts/.bun/_bun" ] && source "/Users/tripproberts/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform


# Summit
export SUMMIT_HOME="/Users/tripproberts/src/summit/"

# Go
export PATH="/usr/local/go/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/tripproberts/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# enable vim mode
bindkey -v

# map ctrl+r to reverse search like emacs
bindkey "^R" history-incremental-search-backward

########## Change cursor shape for different vi modes.
function zle-keymap-select () {
  case $KEYMAP in
    vicmd) echo -ne '\e[2 q';; # block cursor for ohmyzsh. could also be \e[1 q
    viins|main) echo -ne '\e[5 q';; # beam
  esac
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
########### Change cursor shape for different vi modes.

# alias vim and vi to nvim
alias vim="nvim"
alias vi="nvim"

# Go bin
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
