## Invoke starship
eval "$(starship init zsh)"

## Zinit Plugin manger config and download if missing and then source it
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

## ZINIT: Add plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab 

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --icons --group-directories-first -l --no-permissions --no-user --no-time --no-filesize $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'exa --icons --group-directories-first -l --no-permissions --no-user --no-time --no-filesize  $realpath'

# Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Specific bindkeys
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

## Load Auotcompletion 
autoload -U compinit && compinit
source <(kubectl completion zsh)
source <(talhelper completion zsh)

## Load snippts
zinit cdreplay -q

## History
HISTFILE=~/.zsh_histfile
HISTSIZE=9999
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases 
alias vim=nvim
alias ls="exa --icons --group-directories-first"
alias ll="exa --icons --group-directories-first -l -g -a"
alias grep='grep --color'
alias d='docker'
alias k="kubectl"
alias kx="kubecm switch"
alias kc="kubecm"
alias kn="kubecm namespace"
alias cat=bat
ku() {
    kubectl config unset current-context
}


## shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Ensure GPG agent is set for ssh sessions (for Youbikey)
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi


# fzf Catppuccine color theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/robert/.lmstudio/bin"
# End of LM Studio CLI section

