# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### ZINIT SETUP
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


### PLUGINS
# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# # Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found


### Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

### History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


### P10K
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


### Keybinds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


### Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


### Aliases
alias ls='ls --color'
alias vim='nvim'
alias v='nvim'
alias c='clear'
alias http='http --print=hb'


### Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

export GOPATH=$HOME/go

### PATH exports
export PATH=$PATH:/usr/local/go/bin:$GOROOT/bin:$GOPATH/bin:$HOME/.local/lib/python3.12/site-packages:$HOME/scripts

### IQE
export REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt
export DYNACONF_MAIN__use_browser=chrome

function cs-helper {
  local command="$1"
  local arg1="$2"
  local input=$(cat)

  if [[ "$command" == "yank" ]]; then
    if [ -z "$arg1" ]; then
      printf "ERR: No attribute name provided\n" >&2
      return 1
    fi

    # Pass through original content
    echo "$input" | head -n 7
    echo "$input" | tail -n +7 | jq -S --color-output --indent 4

    # Extract value using provided field name
    local value=$(echo "$input" | tail -n +7 | jq -r --arg field "$arg1" '.[$field] // empty')

    if [ -n "$value" ]; then
      # Output variable assignment instead of exporting
      export UUID=$value
      return 0
    else
      printf "ERR: Field '%s' not found\n" "$arg1" >&2
      return 1
    fi
  fi

  printf "Nothing to be found here... 🏗🔧\n"
  printf "Supported commands: 'yank <field-name>'\n"
  return 1
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
