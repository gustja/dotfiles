```bash id="h9m2qp"
#!/usr/bin/env bash

set -Eeuo pipefail

# =========================================================
# DOTFILES SETUP SCRIPT
# =========================================================

echo "======================================"
echo " DOTFILES ENVIRONMENT SETUP"
echo "======================================"

# ---------------------------------------------------------
# Variables
# ---------------------------------------------------------
DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/gustja/dotfiles"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"

# ---------------------------------------------------------
# Helpers
# ---------------------------------------------------------
info() {
    echo "[INFO] $1"
}

success() {
    echo "[OK] $1"
}

warn() {
    echo "[WARN] $1"
}

error() {
    echo "[ERROR] $1"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

create_symlink() {
    local source_file="$1"
    local target_file="$2"

    if [ ! -e "$source_file" ]; then
        warn "Source does not exist: $source_file"
        return 1
    fi

    # Backup existing file if not symlink
    if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
        local backup_file="${target_file}.backup.$(date +%s)"

        info "Backing up:"
        echo "  $target_file -> $backup_file"

        mv "$target_file" "$backup_file"
    fi

    ln -sfn "$source_file" "$target_file"

    success "Linked:"
    echo "  $target_file -> $source_file"
}

# ---------------------------------------------------------
# Check OS
# ---------------------------------------------------------
if ! command_exists apt; then
    error "This script currently supports Debian/Ubuntu systems only."
    exit 1
fi

# ---------------------------------------------------------
# Sudo check
# ---------------------------------------------------------
if ! sudo -v; then
    error "Sudo access required."
    exit 1
fi

# ---------------------------------------------------------
# Update system
# ---------------------------------------------------------
info "Updating system packages..."

sudo apt update
sudo apt upgrade -y

# ---------------------------------------------------------
# Install packages
# ---------------------------------------------------------
info "Installing required packages..."

PACKAGES=(
    git
    curl
    wget
    vim
    neovim
    zsh
    gh
    btop
    fzf
    eza
    build-essential
    python3
    python3-pip
    python3-venv
    unzip
    zip
    ripgrep
    fd-find
    bat
    tmux
)

sudo apt install -y "${PACKAGES[@]}"

success "Packages installed."

# ---------------------------------------------------------
# Clone or update dotfiles
# ---------------------------------------------------------
if [ -d "$DOTFILES_DIR/.git" ]; then
    info "Updating dotfiles repository..."

    git -C "$DOTFILES_DIR" pull origin main
else
    info "Cloning dotfiles repository..."

    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

success "Dotfiles repository ready."

# ---------------------------------------------------------
# Install Oh My Zsh
# ---------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing Oh My Zsh..."

    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    success "Oh My Zsh installed."
else
    success "Oh My Zsh already installed."
fi

# ---------------------------------------------------------
# Install Zsh plugins
# ---------------------------------------------------------
install_plugin() {
    local repo_url="$1"
    local target_dir="$2"

    if [ ! -d "$target_dir" ]; then
        info "Installing plugin:"
        echo "  $target_dir"

        git clone --depth=1 "$repo_url" "$target_dir"

        success "Plugin installed."
    else
        success "Plugin already installed:"
        echo "  $target_dir"
    fi
}

info "Installing Zsh plugins..."

install_plugin \
    "https://github.com/zsh-users/zsh-autosuggestions" \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

install_plugin \
    "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# ---------------------------------------------------------
# Install Powerlevel10k
# ---------------------------------------------------------
if [ ! -d "$P10K_DIR" ]; then
    info "Installing Powerlevel10k..."

    git clone --depth=1 \
        https://github.com/romkatv/powerlevel10k.git \
        "$P10K_DIR"

    success "Powerlevel10k installed."
else
    success "Powerlevel10k already installed."
fi

# ---------------------------------------------------------
# Create config directories
# ---------------------------------------------------------
mkdir -p "$HOME/.config"

# ---------------------------------------------------------
# Symlinks
# ---------------------------------------------------------
info "Creating symbolic links..."

# ZSH
if [ -f "$DOTFILES_DIR/.zshrc" ]; then
    create_symlink \
        "$DOTFILES_DIR/.zshrc" \
        "$HOME/.zshrc"
fi

# P10K
if [ -f "$DOTFILES_DIR/.p10k.zsh" ]; then
    create_symlink \
        "$DOTFILES_DIR/.p10k.zsh" \
        "$HOME/.p10k.zsh"
fi

# Neovim
if [ -d "$DOTFILES_DIR/nvim" ]; then
    create_symlink \
        "$DOTFILES_DIR/nvim" \
        "$HOME/.config/nvim"
fi

# Tmux
if [ -f "$DOTFILES_DIR/.tmux.conf" ]; then
    create_symlink \
        "$DOTFILES_DIR/.tmux.conf" \
        "$HOME/.tmux.conf"
fi

# Git config
if [ -f "$DOTFILES_DIR/.gitconfig" ]; then
    create_symlink \
        "$DOTFILES_DIR/.gitconfig" \
        "$HOME/.gitconfig"
fi

# ---------------------------------------------------------
# Change default shell
# ---------------------------------------------------------
CURRENT_SHELL="$(basename "$SHELL")"

if [ "$CURRENT_SHELL" != "zsh" ]; then
    info "Changing default shell to Zsh..."

    chsh -s "$(which zsh)"

    success "Default shell changed to Zsh."
else
    success "Zsh already default shell."
fi

# ---------------------------------------------------------
# Verify installations
# ---------------------------------------------------------
info "Verifying installation..."

VERIFY_COMMANDS=(
    git
    zsh
    nvim
    python3
    pip3
    fzf
)

for cmd in "${VERIFY_COMMANDS[@]}"; do
    if command_exists "$cmd"; then
        success "$cmd detected."
    else
        warn "$cmd missing."
    fi
done

# ---------------------------------------------------------
# Finish
# ---------------------------------------------------------
echo
echo "======================================"
success "SETUP COMPLETED"
echo "======================================"
echo
echo "Restart terminal or run:"
echo
echo "    exec zsh"
echo
```
