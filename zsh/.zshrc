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
autoload bashcompinit && bashcompinit
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

### Keybinds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -e ${$(tput kDC3 2>/dev/null):-'\e[3;3~'} kill-word
bindkey "^[[3~" delete-char                     # Key Del
bindkey "^[[5~" beginning-of-buffer-or-history  # Key Page Up
bindkey "^[[6~" end-of-buffer-or-history        # Key Page Down
bindkey "^[[H" beginning-of-line                # Key Home
bindkey "^[[F" end-of-line                      # Key End
bindkey "^[[1;3C" forward-word                  # Key Alt + Right
bindkey "^[[1;3D" backward-word                 # Key Alt + Left

### Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


### Aliases
alias ls='ls -a --color'
alias la='ls -a --color'
alias ll='ls -lah --color'
alias vim='nvim'
alias v='nvim'
alias c='clear'
alias http='http --print=hb'
alias restow='cd ~/.dotfiles/ && make && cd -'


### Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

### PATH exports
export PATH=$PATH:/usr/local/go/bin:$GOROOT/bin:$GOPATH/bin:$HOME/.local/lib/python3.12/site-packages:$HOME/scripts:$HOME/.local/bin:$HOME/.cargo/bin
export GOPATH=$HOME/go
export XDG_DATA_DIRS="$HOME/.local/share/applications/:$XDG_DATA_DIRS"
export EDITOR='nvim'

eval "$(mise activate zsh)"
eval "$(starship init zsh)"

# bun completions
[ -s "/home/dvagner/.bun/_bun" ] && source "/home/dvagner/.bun/_bun"

complete -C '/home/dvagner/.local/bin/aws_completer' aws
eval "$(LC_ALL=C _PULP_COMPLETE=zsh_source pulp)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/home/dvagner/.opencode/bin:$PATH

fpath+=~/.zfunc; autoload -Uz compinit; compinit
