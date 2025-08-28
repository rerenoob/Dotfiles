#!/bin/bash

# Linux Dotfiles Installation Script
# Installs and configures dotfiles for Linux systems (Ubuntu/Debian and RHEL/CentOS/Fedora)

# set -e  # Exit on error - commented out for graceful error handling

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Array to track failed steps
FAILED_STEPS=()

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

# Function to add failed step
add_failure() {
    FAILED_STEPS+=("$1")
    log_error "$1"
}

# Detect Linux distribution
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        DISTRO=$ID
        DISTRO_FAMILY=$ID_LIKE
    elif [[ -f /etc/redhat-release ]]; then
        DISTRO="rhel"
        DISTRO_FAMILY="rhel"
    elif [[ -f /etc/debian_version ]]; then
        DISTRO="debian"
        DISTRO_FAMILY="debian"
    else
        log_error "Cannot detect Linux distribution"
        exit 1
    fi
    
    log_success "Detected distribution: $DISTRO"
}

# Check if running on Linux
check_linux() {
    if [[ "$OSTYPE" != "linux-gnu"* ]]; then
        log_error "This script is for Linux only. Use install-macos.sh for macOS systems."
        exit 1
    fi
    log_success "Running on Linux"
}

# Update package manager
update_packages() {
    log_info "Updating package manager..."
    
    case $DISTRO_FAMILY in
        *debian*|*ubuntu*)
            if sudo apt-get update -y; then
                log_success "APT packages updated"
            else
                add_failure "Failed to update APT packages"
            fi
            ;;
        *rhel*|*fedora*|*centos*)
            if command -v dnf &> /dev/null; then
                if sudo dnf update -y; then
                    log_success "DNF packages updated"
                else
                    add_failure "Failed to update DNF packages"
                fi
            elif command -v yum &> /dev/null; then
                if sudo yum update -y; then
                    log_success "YUM packages updated"
                else
                    add_failure "Failed to update YUM packages"
                fi
            fi
            ;;
        *arch*)
            if sudo pacman -Syu --noconfirm; then
                log_success "Pacman packages updated"
            else
                add_failure "Failed to update Pacman packages"
            fi
            ;;
        *)
            log_warning "Unknown package manager, skipping update"
            ;;
    esac
}

# Install required packages
install_packages() {
    log_info "Installing required packages..."
    
    case $DISTRO_FAMILY in
        *debian*|*ubuntu*)
            local packages=(
                "fish"
                "neovim"
                "git"
                "curl"
                "python3"
                "python3-pip"
                "build-essential"
                "tree"
                "unzip"
            )
            
            for package in "${packages[@]}"; do
                if dpkg -l | grep -q "^ii  $package "; then
                    log_success "$package already installed"
                else
                    log_info "Installing $package..."
                    if sudo apt-get install -y "$package"; then
                        log_success "$package installed"
                    else
                        add_failure "Failed to install package: $package"
                    fi
                fi
            done
            
            # Install ripgrep (newer versions)
            if ! command -v rg &> /dev/null; then
                log_info "Installing ripgrep..."
                if curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb && sudo dpkg -i ripgrep_13.0.0_amd64.deb; then
                    rm ripgrep_13.0.0_amd64.deb
                    log_success "ripgrep installed"
                else
                    add_failure "Failed to install ripgrep"
                    rm -f ripgrep_13.0.0_amd64.deb
                fi
            else
                log_success "ripgrep already installed"
            fi
            ;;
            
        *rhel*|*fedora*|*centos*)
            local packages=(
                "fish"
                "neovim"
                "git"
                "curl"
                "python3"
                "python3-pip"
                "gcc"
                "gcc-c++"
                "make"
                "tree"
                "unzip"
                "ripgrep"
            )
            
            local pkg_manager="dnf"
            if ! command -v dnf &> /dev/null; then
                pkg_manager="yum"
            fi
            
            for package in "${packages[@]}"; do
                if rpm -q "$package" &>/dev/null; then
                    log_success "$package already installed"
                else
                    log_info "Installing $package..."
                    if sudo $pkg_manager install -y "$package"; then
                        log_success "$package installed"
                    else
                        add_failure "Failed to install package: $package"
                    fi
                fi
            done
            ;;
            
        *arch*)
            local packages=(
                "fish"
                "neovim"
                "git"
                "curl"
                "python"
                "python-pip"
                "base-devel"
                "tree"
                "unzip"
                "ripgrep"
            )
            
            for package in "${packages[@]}"; do
                if pacman -Q "$package" &>/dev/null; then
                    log_success "$package already installed"
                else
                    log_info "Installing $package..."
                    if sudo pacman -S --noconfirm "$package"; then
                        log_success "$package installed"
                    else
                        add_failure "Failed to install package: $package"
                    fi
                fi
            done
            ;;
            
        *)
            log_error "Unsupported distribution family: $DISTRO_FAMILY"
            log_info "Please install the following packages manually:"
            echo "- fish, neovim, git, curl, python3, python3-pip, ripgrep, tree"
            exit 1
            ;;
    esac
}

# Install FZF manually since it's not always in package repos
install_fzf() {
    if command -v fzf &> /dev/null; then
        log_success "FZF already installed"
        return
    fi
    
    log_info "Installing FZF..."
    if git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all --no-update-rc; then
        # Add to PATH for current session
        export PATH="$HOME/.fzf/bin:$PATH"
        log_success "FZF installed"
    else
        add_failure "Failed to install FZF"
    fi
}

# Install Python packages
install_python_packages() {
    log_info "Installing Python packages..."
    
    # Install requests for quote script
    if python3 -c "import requests" &>/dev/null; then
        log_success "requests already installed"
    else
        log_info "Installing requests..."
        if pip3 install --user requests; then
            log_success "requests installed"
        else
            add_failure "Failed to install Python package: requests"
        fi
    fi
    
    # Install virtualfish for Fish shell
    if python3 -c "import virtualfish" &>/dev/null; then
        log_success "virtualfish already installed"
    else
        log_info "Installing virtualfish..."
        if pip3 install --user virtualfish; then
            log_success "virtualfish installed"
        else
            add_failure "Failed to install Python package: virtualfish"
        fi
    fi
}

# Backup existing dotfiles
backup_existing() {
    log_info "Backing up existing dotfiles..."
    local backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    
    if ! mkdir -p "$backup_dir"; then
        add_failure "Failed to create backup directory: $backup_dir"
        return 1
    fi
    
    local files_to_backup=(
        "$HOME/.vimrc"
        "$HOME/.bashrc"
        "$HOME/.config/fish/config.fish"
    )
    
    for file in "${files_to_backup[@]}"; do
        if [[ -f "$file" ]]; then
            if cp "$file" "$backup_dir/"; then
                log_success "Backed up $(basename "$file")"
            else
                add_failure "Failed to backup $(basename "$file")"
            fi
        fi
    done
    
    if [[ -n "$(ls -A "$backup_dir" 2>/dev/null)" ]]; then
        log_success "Backup created at $backup_dir"
    else
        rmdir "$backup_dir" 2>/dev/null || true
        log_info "No existing dotfiles found to backup"
    fi
}

# Create symbolic links
create_symlinks() {
    log_info "Creating symbolic links..."
    
    local dotfiles_dir="$PWD"
    
    # Vim configuration
    if [[ -f "$dotfiles_dir/vimrc" ]]; then
        if ln -sf "$dotfiles_dir/vimrc" "$HOME/.vimrc"; then
            log_success "Linked .vimrc"
        else
            add_failure "Failed to link .vimrc"
        fi
    fi
    
    # Bash configuration
    if [[ -f "$dotfiles_dir/bashrc" ]]; then
        if ln -sf "$dotfiles_dir/bashrc" "$HOME/.bashrc"; then
            log_success "Linked .bashrc"
        else
            add_failure "Failed to link .bashrc"
        fi
    fi
    
    # Fish configuration
    if ! mkdir -p "$HOME/.config/fish"; then
        add_failure "Failed to create Fish config directory"
        return 1
    fi
    if [[ -f "$dotfiles_dir/config.fish" ]]; then
        if ln -sf "$dotfiles_dir/config.fish" "$HOME/.config/fish/config.fish"; then
            log_success "Linked Fish config"
        else
            add_failure "Failed to link Fish config"
        fi
    fi
    
    # Note: Hyper.js is less common on Linux, so we skip it
    if [[ -f "$dotfiles_dir/hyper.js" ]]; then
        if ln -sf "$dotfiles_dir/hyper.js" "$HOME/.hyper.js"; then
            log_success "Linked Hyper config (if using Hyper terminal)"
        else
            add_failure "Failed to link Hyper config"
        fi
    fi
}

# Install Fish shell plugins and themes
setup_fish() {
    log_info "Setting up Fish shell..."
    
    # Install Fisher (Fish plugin manager)
    if ! fish -c "functions -q fisher" 2>/dev/null; then
        log_info "Installing Fisher..."
        if fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher" 2>/dev/null; then
            log_success "Fisher installed"
        else
            add_failure "Failed to install Fisher plugin manager"
        fi
    else
        log_success "Fisher already installed"
    fi
    
    # Install bobthefish theme
    log_info "Installing bobthefish theme..."
    if fish -c "fisher install oh-my-fish/theme-bobthefish" 2>/dev/null; then
        log_success "bobthefish theme installed"
    else
        add_failure "Failed to install bobthefish theme"
    fi
    
    # Set Fish as default shell
    local fish_path
    if fish_path=$(which fish); then
        if [[ "$SHELL" != "$fish_path" ]]; then
            log_info "Setting Fish as default shell..."
            if ! grep -q "$fish_path" /etc/shells; then
                if ! echo "$fish_path" | sudo tee -a /etc/shells; then
                    add_failure "Failed to add Fish to /etc/shells"
                    return 1
                fi
            fi
            if chsh -s "$fish_path"; then
                log_success "Fish set as default shell"
            else
                add_failure "Failed to set Fish as default shell"
            fi
        else
            log_success "Fish already set as default shell"
        fi
    else
        add_failure "Fish executable not found in PATH"
    fi
}

# Install Vim plugins
setup_vim() {
    log_info "Setting up Vim plugins..."
    
    # Run the plugin installation script
    if [[ -f "$PWD/install-vim-plugins.sh" ]]; then
        log_info "Installing Vim plugins automatically..."
        if bash "$PWD/install-vim-plugins.sh" install; then
            log_success "Vim plugins installed"
        else
            add_failure "Failed to install Vim plugins automatically"
            log_info "Attempting manual plugin installation..."
            # Fallback: try direct vim command
            if vim +PlugInstall +qall; then
                log_success "Vim plugins installed via direct command"
            else
                add_failure "Failed to install Vim plugins - you may need to run ':PlugInstall' manually in Vim"
            fi
        fi
    else
        log_warning "Plugin installation script not found"
        log_info "Attempting direct plugin installation..."
        # Try direct vim command
        if vim +PlugInstall +qall; then
            log_success "Vim plugins installed via direct command"
        else
            log_warning "Direct installation failed - Run ':PlugInstall' manually in Vim to install plugins"
        fi
    fi
    
    log_success "Vim configuration ready"
}

# Setup FZF integration
setup_fzf_integration() {
    log_info "Setting up FZF shell integration..."
    
    # FZF integration should already be set up from install_fzf function
    if [[ -f "$HOME/.fzf.bash" ]]; then
        log_success "FZF bash integration ready"
    else
        log_warning "FZF bash integration may need manual setup"
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
            if mkdir -p "$dir"; then
                log_success "Created directory: $dir"
            else
                add_failure "Failed to create directory: $dir"
            fi
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
    
    # Test FZF
    if command -v fzf &>/dev/null; then
        log_success "FZF available"
    else
        log_warning "FZF not found in PATH"
    fi
    
    # Test ripgrep
    if command -v rg &>/dev/null; then
        log_success "ripgrep available"
    else
        log_warning "ripgrep not found in PATH"
    fi
}

# Main installation function
main() {
    echo "==============================================="
    echo "      Linux Dotfiles Installation Script      "
    echo "==============================================="
    echo
    
    check_linux || true
    detect_distro || true
    update_packages || true
    install_packages || true
    install_fzf || true
    install_python_packages || true
    backup_existing || true
    create_symlinks || true
    setup_fish || true
    setup_vim || true
    setup_fzf_integration || true
    create_directories || true
    test_installation || true
    
    echo
    echo "==============================================="
    
    # Show summary of any failures
    if [[ ${#FAILED_STEPS[@]} -eq 0 ]]; then
        log_success "Installation completed successfully!"
        echo "==============================================="
    else
        log_warning "Installation completed with some issues:"
        echo "==============================================="
        echo
        log_error "The following steps failed:"
        for failure in "${FAILED_STEPS[@]}"; do
            echo "  • $failure"
        done
        echo
        log_info "Despite these failures, other components may still work correctly."
    fi
    
    echo
    log_info "Next steps:"
    echo "1. Restart your terminal or run: source ~/.bashrc"
    echo "2. Open Vim/Neovim and run :PlugInstall to install plugins"
    echo "3. If using Fish shell, restart terminal to see new theme"
    echo "4. Test quote script: python3 quoteoftheday.py"
    echo "5. You may need to add ~/.local/bin to your PATH for Python packages"
    echo
    log_info "For Fish shell features, you may need to restart your terminal."
    log_info "If you encounter permission issues, ensure your user is in the sudo group."
    
    if [[ ${#FAILED_STEPS[@]} -gt 0 ]]; then
        log_info "Review the failed steps above and manually address any issues."
    fi
}

# Run main function
main "$@"
