#!/bin/bash

# Vim/Neovim Plugin Installation Script
# Automatically installs all plugins defined in vimrc

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

# Check if vim or neovim is available
check_vim_available() {
    if command -v nvim &> /dev/null; then
        VIM_CMD="nvim"
        VIM_NAME="Neovim"
        log_success "$VIM_NAME found"
    elif command -v vim &> /dev/null; then
        VIM_CMD="vim"
        VIM_NAME="Vim"
        log_success "$VIM_NAME found"
    else
        log_error "Neither Vim nor Neovim found. Please install one of them first."
        exit 1
    fi
}

# Install vim-plug if not already installed
install_vim_plug() {
    local plug_path
    
    if [[ "$VIM_CMD" == "nvim" ]]; then
        plug_path="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
        plug_dir="$(dirname "$plug_path")"
    else
        plug_path="$HOME/.vim/autoload/plug.vim"
        plug_dir="$(dirname "$plug_path")"
    fi
    
    if [[ ! -f "$plug_path" ]]; then
        log_info "Installing vim-plug..."
        mkdir -p "$plug_dir"
        curl -fLo "$plug_path" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        log_success "vim-plug installed"
    else
        log_success "vim-plug already installed"
    fi
}

# Install plugins using vim-plug
install_plugins() {
    log_info "Installing $VIM_NAME plugins..."
    log_info "This may take a few minutes..."
    
    # Create a temporary vim script to install plugins
    local temp_script=$(mktemp)
    cat > "$temp_script" << 'EOF'
" Suppress all output except errors
set nomore
set shortmess+=I
set cmdheight=2

" Install plugins
PlugInstall --sync

" Quit all windows
qall!
EOF
    
    # Run the installation
    if $VIM_CMD -u "$HOME/.vimrc" -s "$temp_script" &> /dev/null; then
        log_success "All plugins installed successfully!"
    else
        log_warning "Plugin installation completed, but there may have been some issues"
        log_info "You can run ':PlugInstall' manually in $VIM_NAME to check for any problems"
    fi
    
    # Clean up
    rm -f "$temp_script"
}

# Update existing plugins
update_plugins() {
    log_info "Updating existing plugins..."
    
    local temp_script=$(mktemp)
    cat > "$temp_script" << 'EOF'
" Suppress all output except errors
set nomore
set shortmess+=I
set cmdheight=2

" Update plugins
PlugUpdate --sync

" Quit all windows
qall!
EOF
    
    if $VIM_CMD -u "$HOME/.vimrc" -s "$temp_script" &> /dev/null; then
        log_success "All plugins updated successfully!"
    else
        log_warning "Plugin update completed, but there may have been some issues"
        log_info "You can run ':PlugUpdate' manually in $VIM_NAME to check for any problems"
    fi
    
    rm -f "$temp_script"
}

# Clean unused plugins
clean_plugins() {
    log_info "Cleaning unused plugins..."
    
    local temp_script=$(mktemp)
    cat > "$temp_script" << 'EOF'
" Suppress all output except errors
set nomore
set shortmess+=I
set cmdheight=2

" Clean unused plugins
PlugClean!

" Quit all windows
qall!
EOF
    
    if $VIM_CMD -u "$HOME/.vimrc" -s "$temp_script" &> /dev/null; then
        log_success "Plugin cleanup completed!"
    else
        log_info "Plugin cleanup completed"
    fi
    
    rm -f "$temp_script"
}

# Check plugin installation status
check_plugin_status() {
    log_info "Checking plugin installation status..."
    
    if [[ "$VIM_CMD" == "nvim" ]]; then
        local plugin_dir="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/plugged"
    else
        local plugin_dir="$HOME/.vim/plugged"
    fi
    
    if [[ -d "$plugin_dir" ]]; then
        local plugin_count=$(find "$plugin_dir" -maxdepth 1 -type d | wc -l)
        plugin_count=$((plugin_count - 1))  # Subtract the parent directory
        
        if [[ $plugin_count -gt 0 ]]; then
            log_success "$plugin_count plugins installed in $plugin_dir"
            
            # List installed plugins
            log_info "Installed plugins:"
            for plugin in "$plugin_dir"/*/; do
                if [[ -d "$plugin" ]]; then
                    plugin_name=$(basename "$plugin")
                    echo "  • $plugin_name"
                fi
            done
        else
            log_warning "No plugins found in $plugin_dir"
        fi
    else
        log_warning "Plugin directory not found: $plugin_dir"
    fi
}

# Show help
show_help() {
    echo "Vim/Neovim Plugin Installation Script"
    echo ""
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  install     Install all plugins (default)"
    echo "  update      Update existing plugins"
    echo "  clean       Remove unused plugins"
    echo "  status      Show installed plugin status"
    echo "  help        Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0              # Install all plugins"
    echo "  $0 install      # Install all plugins"
    echo "  $0 update       # Update existing plugins"
    echo "  $0 clean        # Clean unused plugins"
    echo "  $0 status       # Show plugin status"
}

# Main function
main() {
    local action="${1:-install}"
    
    case "$action" in
        "install")
            echo "========================================"
            echo "    Vim Plugin Installation Script     "
            echo "========================================"
            echo
            
            check_vim_available
            install_vim_plug
            install_plugins
            check_plugin_status
            
            echo
            log_success "Plugin installation completed!"
            log_info "Restart $VIM_NAME to use the new plugins"
            ;;
            
        "update")
            echo "========================================"
            echo "     Vim Plugin Update Script         "
            echo "========================================"
            echo
            
            check_vim_available
            update_plugins
            check_plugin_status
            
            echo
            log_success "Plugin update completed!"
            ;;
            
        "clean")
            echo "========================================"
            echo "     Vim Plugin Cleanup Script        "
            echo "========================================"
            echo
            
            check_vim_available
            clean_plugins
            
            echo
            log_success "Plugin cleanup completed!"
            ;;
            
        "status")
            echo "========================================"
            echo "     Vim Plugin Status Check          "
            echo "========================================"
            echo
            
            check_vim_available
            check_plugin_status
            ;;
            
        "help"|"-h"|"--help")
            show_help
            ;;
            
        *)
            log_error "Unknown option: $action"
            echo
            show_help
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"