# Dotfiles

Personal dotfiles for macOS and Linux systems, featuring Fish shell, Neovim, FZF integration, and comprehensive development tools.

## Features

🐠 **Fish Shell** - Modern shell with intelligent autosuggestions and syntax highlighting  
⚡ **Neovim** - Enhanced Vim with modern plugins and configurations  
🔍 **FZF Integration** - Fuzzy finding for files, git branches, and command history  
📝 **Vimwiki** - Personal note-taking system with markdown support  
🎯 **Git Shortcuts** - Streamlined git workflow with custom aliases  
📊 **System Monitoring** - Enhanced system information and performance tools  
💬 **Daily Quotes** - Inspirational quotes in your terminal greeting  

## Quick Installation

### Automated Setup

**macOS:**
```bash
git clone https://github.com/rerenoob/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles
./install-macos.sh
```

**Linux (Ubuntu/Debian/RHEL/Fedora/Arch):**
```bash
git clone https://github.com/rerenoob/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles
./install-linux.sh
```

### What Gets Installed

The installation scripts will:
- ✅ Install Fish shell, Neovim, FZF, ripgrep, and Python packages
- ✅ Set up Fish shell with bobthefish theme and plugin manager
- ✅ Automatically install all Vim/Neovim plugins
- ✅ Create symbolic links to dotfiles in your home directory
- ✅ Back up your existing dotfiles
- ✅ Set up directory structure for notes and projects

## Manual Installation

For manual setup instructions, see [CLAUDE.md](CLAUDE.md#installation).

## Key Components

- **`vimrc`** - Comprehensive Vim configuration with modern plugins
- **`config.fish`** - Fish shell with custom functions and theme
- **`bashrc`** - Bash configuration with consistent aliases
- **`quoteoftheday.py`** - Python script for daily inspirational quotes
- **`hyper.js`** - Hyper terminal configuration

## Post-Installation

1. Restart your terminal to apply changes
2. Run `:PlugInstall` in Vim/Neovim to install plugins  
3. Test the setup: `python3 quoteoftheday.py`

## Documentation

For detailed configuration information and advanced setup, see [CLAUDE.md](CLAUDE.md).
