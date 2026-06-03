# Ceļš uz Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Aktivizē Powerlevel10k tēmu
ZSH_THEME="powerlevel10k/powerlevel10k"

# Pievieno vietējo bin mapi lietotāja PATH (vajadzīgs labotajam 'bat')
export PATH="$HOME/.local/bin:$PATH"

# Uzdevumā prasītie spraudņi
plugins=(
    git
    fzf
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# --- MODERNO CLI RĪKU KONFIGURĀCIJA (4. punkts) ---

# Zoxide (viedā cd alternatīva) inicializācija
eval "$(zoxide init zsh)"

# Eza aliasi ar Nerd Font ikonām un direktoriju kārtošanu saraksta sākumā
alias ls='eza -la --icons --group-directories-first'
alias ll='eza -l --icons'
alias lt='eza --tree --icons'

# Bat alias, lai aizstātu standarta 'cat' ar sintakses iekrāsošanu
alias cat='bat --style=plain'

# Ielādē p10k vizuālo konfigurāciju, ja tā eksistē
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
