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
export PATH=$PATH:/usr/local/go/bin:$GOROOT/bin:$GOPATH/bin:$HOME/.local/lib/python3.12/site-packages:$HOME/scripts:$HOME/.local/bin
export GOPATH=$HOME/go
export XDG_DATA_DIRS="$HOME/.local/share/applications/:$XDG_DATA_DIRS"
export EDITOR='nvim'

### IQE
export REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt
export DYNACONF_MAIN__use_browser=chrome

### FUNCTIONS
function cursor {
  (nohup "$HOME/Applications/Cursor-1.1.3-x86_64.AppImage" "$@" > /dev/null 2>&1 &)
}

unset http_proxy;
unset https_proxy;
unset HTTP_PROXY;
unset HTTPS_PROXY;

eval "$(mise activate zsh)"
