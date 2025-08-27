#!/bin/bash

# macOS Dotfiles Installation Script
# Installs and configures dotfiles for macOS systems

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        log_error "This script is for macOS only. Use install-linux.sh for Linux systems."
        exit 1
    fi
    log_success "Running on macOS"
}

# Install Homebrew if not present
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        log_success "Homebrew installed"
    else
        log_success "Homebrew already installed"
    fi
}

# Install required packages via Homebrew
install_packages() {
    log_info "Installing required packages via Homebrew..."
    
    local packages=(
        "fish"          # Fish shell
        "neovim"        # Modern Vim
        "fzf"           # Fuzzy finder
        "ripgrep"       # Fast grep alternative
        "git"           # Version control
        "python@3.11"   # Python 3
        "curl"          # HTTP client
        "tree"          # Directory tree viewer
    )
    
    for package in "${packages[@]}"; do
        if brew list "$package" &>/dev/null; then
            log_success "$package already installed"
        else
            log_info "Installing $package..."
            brew install "$package"
            log_success "$package installed"
        fi
    done
}

# Install Python packages
install_python_packages() {
    log_info "Installing Python packages..."
    
    # Install requests for quote script
    if python3 -c "import requests" &>/dev/null; then
        log_success "requests already installed"
    else
        log_info "Installing requests..."
        pip3 install --user --break-system-packages requests 2>/dev/null || pip3 install --user requests
        log_success "requests installed"
    fi
    
    # Install virtualfish for Fish shell
    if python3 -c "import virtualfish" &>/dev/null; then
        log_success "virtualfish already installed"
    else
        log_info "Installing virtualfish..."
        pip3 install --user --break-system-packages virtualfish 2>/dev/null || pip3 install --user virtualfish
        log_success "virtualfish installed"
    fi
}

# Backup existing dotfiles
backup_existing() {
    log_info "Backing up existing dotfiles..."
    local backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    
    local files_to_backup=(
        "$HOME/.vimrc"
        "$HOME/.bashrc"
        "$HOME/.config/fish/config.fish"
    )
    
    for file in "${files_to_backup[@]}"; do
        if [[ -f "$file" ]]; then
            cp "$file" "$backup_dir/"
            log_success "Backed up $(basename "$file")"
        fi
    done
    
    if [[ -n "$(ls -A "$backup_dir" 2>/dev/null)" ]]; then
        log_success "Backup created at $backup_dir"
    else
        rmdir "$backup_dir"
        log_info "No existing dotfiles found to backup"
    fi
}

# Create symbolic links
create_symlinks() {
    log_info "Creating symbolic links..."
    
    local dotfiles_dir="$PWD"
    
    # Vim configuration
    if [[ -f "$dotfiles_dir/vimrc" ]]; then
        ln -sf "$dotfiles_dir/vimrc" "$HOME/.vimrc"
        log_success "Linked .vimrc"
    fi
    
    # Bash configuration
    if [[ -f "$dotfiles_dir/bashrc" ]]; then
        ln -sf "$dotfiles_dir/bashrc" "$HOME/.bashrc"
        log_success "Linked .bashrc"
    fi
    
    # Fish configuration
    mkdir -p "$HOME/.config/fish"
    if [[ -f "$dotfiles_dir/config.fish" ]]; then
        ln -sf "$dotfiles_dir/config.fish" "$HOME/.config/fish/config.fish"
        log_success "Linked Fish config"
    fi
    
    # Hyper terminal configuration
    if [[ -f "$dotfiles_dir/hyper.js" ]]; then
        ln -sf "$dotfiles_dir/hyper.js" "$HOME/.hyper.js"
        log_success "Linked Hyper config"
    fi
}

# Install Fish shell plugins and themes
setup_fish() {
    log_info "Setting up Fish shell..."
    
    # Install Fisher (Fish plugin manager)
    if ! fish -c "functions -q fisher" 2>/dev/null; then
        log_info "Installing Fisher..."
        fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
        log_success "Fisher installed"
    else
        log_success "Fisher already installed"
    fi
    
    # Install bobthefish theme
    log_info "Installing bobthefish theme..."
    fish -c "fisher install oh-my-fish/theme-bobthefish" 2>/dev/null || true
    log_success "bobthefish theme installed"
    
    # Set Fish as default shell
    local fish_path
    fish_path=$(which fish)
    if [[ "$SHELL" != "$fish_path" ]]; then
        log_info "Setting Fish as default shell..."
        if ! grep -q "$fish_path" /etc/shells; then
            echo "$fish_path" | sudo tee -a /etc/shells
        fi
        chsh -s "$fish_path"
        log_success "Fish set as default shell"
    else
        log_success "Fish already set as default shell"
    fi
}

# Install Vim plugins
setup_vim() {
    log_info "Setting up Vim plugins..."
    
    # Run the plugin installation script
    if [[ -f "$PWD/install-vim-plugins.sh" ]]; then
        log_info "Installing Vim plugins automatically..."
        bash "$PWD/install-vim-plugins.sh" install
        log_success "Vim plugins installed"
    else
        log_warning "Plugin installation script not found"
        log_info "Run ':PlugInstall' manually in Vim to install plugins"
    fi
    
    log_success "Vim configuration ready"
}

# Setup FZF integration
setup_fzf() {
    log_info "Setting up FZF integration..."
    
    # Install FZF shell integration
    if [[ ! -f "$HOME/.fzf.bash" ]]; then
        $(brew --prefix)/opt/fzf/install --all --no-update-rc
        log_success "FZF shell integration installed"
    else
        log_success "FZF already configured"
    fi
}

# Create required directories
create_directories() {
    log_info "Creating required directories..."
    
    local directories=(
        "$HOME/Documents/Notes"
        "$HOME/Documents/Notes/diary"
        "$HOME/Music"
        "$HOME/Projects"
    )
    
    for dir in "${directories[@]}"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
            log_success "Created directory: $dir"
        else
            log_success "Directory already exists: $dir"
        fi
    done
}

# Test installation
test_installation() {
    log_info "Testing installation..."
    
    # Test quote script
    if python3 quoteoftheday.py &>/dev/null; then
        log_success "Quote script working"
    else
        log_warning "Quote script may need attention"
    fi
    
    # Test Fish shell
    if command -v fish &>/dev/null; then
        log_success "Fish shell available"
    else
        log_warning "Fish shell not found in PATH"
    fi
    
    # Test Neovim
    if command -v nvim &>/dev/null; then
        log_success "Neovim available"
    else
        log_warning "Neovim not found in PATH"
    fi
}

# Main installation function
main() {
    echo "==============================================="
    echo "      macOS Dotfiles Installation Script      "
    echo "==============================================="
    echo
    
    check_macos
    install_homebrew
    install_packages
    install_python_packages
    backup_existing
    create_symlinks
    setup_fish
    setup_vim
    setup_fzf
    create_directories
    test_installation
    
    echo
    echo "==============================================="
    log_success "Installation completed successfully!"
    echo "==============================================="
    echo
    log_info "Next steps:"
    echo "1. Restart your terminal or run: source ~/.bashrc"
    echo "2. Open Vim and run :PlugInstall to install plugins"
    echo "3. If using Fish shell, restart terminal to see new theme"
    echo "4. Test quote script: python3 quoteoftheday.py"
    echo
    log_info "For Fish shell features, you may need to restart your terminal."
}

# Run main function
main "$@"