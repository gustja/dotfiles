export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

export PATH="$HOME/.local/bin:$PATH"

plugins=(
    git
    fzf
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"


alias ls='eza -la --icons --group-directories-first'
alias ll='eza -l --icons'
alias lt='eza --tree --icons'
alias cat='bat --style=plain'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
