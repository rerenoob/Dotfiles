# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About This Repository

This is a personal dotfiles repository containing configuration files for various development tools and shell environments on macOS.

## Repository Structure

- **Shell Configuration**: Both Fish shell (`config.fish`) and Bash (`bashrc`, `bash/`) configurations
- **Editor Configuration**: Vim/Neovim setup with plugins via vim-plug (`vimrc`)
- **Terminal Configuration**: Hyper terminal customization (`hyper.js`)
- **Python Scripts**: Daily quote fetcher (`quoteoftheday.py`)

## Key Configuration Files

### Shell Environments
- `config.fish` - Fish shell configuration with bobthefish theme, custom functions, and virtualfish integration
- `bashrc` - Bash shell configuration that sources modular alias and environment files, includes FZF integration
- `bash/alias` - Comprehensive bash aliases for directories, git operations, system monitoring, and network testing
- `bash/env` - Environment variables, git branch parsing function, custom PS1 prompt, and FZF configuration

### Editor Setup
- `vimrc` - Comprehensive Vim configuration with auto-installation of vim-plug
  - **Vimwiki**: Markdown-based note system in `~/Documents/Notes/`
  - **Plugin Management**: 11 productivity plugins including NERDTree, FZF, Fugitive, auto-pairs, surround
  - **Key Remapping**: Visual line navigation and search clearing
  - **Language Support**: Python host configuration, spell checking for markdown
  - **Text Formatting**: 80-character width, smart indentation, clipboard integration

### Terminal
- `hyper.js` - Comprehensive Hyper terminal configuration
  - **Appearance**: Nerd fonts, dark theme, custom cursor and colors
  - **Functionality**: Extensive keybindings for panes, tabs, and editor commands
  - **Integration**: Fish shell as default with login arguments

### Scripts
- `quoteoftheday.py` - Python script that fetches inspirational quotes from quotes.rest API with fallback quote

## Shell Aliases and Functions

### Common Aliases (Both Fish and Bash)
- `python` - Alias to `python3`
- `lsa` - Alias to `ls -la`
- `vi` - Alias to `nvim` (Neovim)
- `chat` - Runs `~/chat.sh` script (Fish only)

### Directory Navigation Shortcuts
- `home` - Navigate to home directory (`~`)
- `doc` - Navigate to `~/Documents`
- `download` - Navigate to `~/Downloads`
- `music` - Navigate to `~/Music`
- `project` - Navigate to `~/Projects`
- `dotfile` - Navigate to `~/Dotfiles` (Fish only)
- `notes` - Navigate to `~/Documents/Notes` (Fish only)

### Git Shortcuts (Both Shells)
- `gbr` - Interactive branch checkout with FZF
- `glg` - Git log with graph visualization (`git log --graph --oneline --decorate --all`)
- `gld` - Git log with date formatting (`git log --pretty=format:"%h %ad %s" --date=short --all`)
- `gs` - Git status
- `gd` - Git diff
- `ga` - Git add
- `gcm` - Git commit with message
- `gco` - Git checkout (Fish only)
- `glf()` - Git log grep function (Bash only)

### Fish Shell Specific Functions
- `cl` - Combined cd and ls command
- `note` - Opens daily diary with git pull (navigates to `~/Documents/Notes`)
- `push_note` - Commits and pushes diary entries with auto-generated commit message
- `readings` - Pulls latest readings repository (`~/Documents/readings`)
- `mo_diary` - Opens personal diary (`~/Documents/ToMyLittleMan-Alan/diary.md`)
- `mo_push_diary` - Commits and pushes personal diary with "Update diary" message
- `focus` - Plays focus music using afplay (`~/Music/focus.mp3`)
- `pause_af` / `resume_af` / `stop_af` - Control afplay audio playback
- `pid_for_name` - Get process ID by name
- `fish_greeting` - Custom greeting with quote of the day

### System Utilities
- `sysinfo` - Enhanced top command with CPU and memory stats
- `speedtest` - Simple network speed test using curl

## Development Tools

### FZF Configuration
- Default height: 70% with file preview
- Uses ripgrep for file finding
- Integrated with git branch selection

### Python Environment
- Python 3.7 configured in PATH (`/Library/Frameworks/Python.framework/Versions/3.7/bin`)
- Uses Python 3 as default via alias
- Virtualfish for Python virtual environment management with compat_aliases
- Python host programs configured for Vim/Neovim
- Quote of the day script requires `requests` library and fetches from quotes.rest API

## System Requirements and Dependencies

### Required Tools
- **Fish Shell**: `/usr/local/bin/fish` (set as default shell in Hyper)
- **Neovim**: Aliased as `vi`
- **FZF**: File finder with preview integration
- **Ripgrep** (`rg`): Fast text search tool
- **Git**: Version control with custom shortcuts
- **Python 3**: With `requests` library for quote script
- **Virtualfish**: Python virtual environment manager
- **Vim-plug**: Plugin manager for Vim/Neovim

### Optional Tools
- **afplay**: Audio player for focus music functionality
- **curl**: For speed test functionality

## Installation

### Automated Installation

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

### What the Installation Scripts Do

Both scripts will:
- ✅ **Detect your system** and install appropriate packages
- ✅ **Backup existing dotfiles** to timestamped backup directory
- ✅ **Install required dependencies** (Fish, Neovim, FZF, ripgrep, Python packages)
- ✅ **Create symbolic links** to dotfiles in your home directory
- ✅ **Set up Fish shell** with Fisher plugin manager and bobthefish theme
- ✅ **Install all Vim/Neovim plugins** automatically using dedicated script
- ✅ **Configure FZF integration** for enhanced file searching
- ✅ **Create required directories** for notes and projects
- ✅ **Test installation** to verify everything works

### Manual Installation

If you prefer manual setup:

#### Prerequisites
- **Fish Shell**: Modern shell with better defaults
- **Neovim**: Modern Vim implementation
- **FZF**: Fuzzy file finder
- **Ripgrep**: Fast text search
- **Python 3**: With pip for package management

#### Step-by-Step
1. **Clone repository:**
   ```bash
   git clone https://github.com/rerenoob/Dotfiles.git ~/Dotfiles
   cd ~/Dotfiles
   ```

2. **Install dependencies:**
   ```bash
   # macOS (using Homebrew)
   brew install fish neovim fzf ripgrep python@3.11
   
   # Ubuntu/Debian
   sudo apt install fish neovim git curl python3 python3-pip
   
   # Install FZF manually
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install --all
   ```

3. **Install Python packages:**
   ```bash
   pip3 install --user requests virtualfish
   ```

4. **Create symbolic links:**
   ```bash
   ln -sf ~/Dotfiles/vimrc ~/.vimrc
   ln -sf ~/Dotfiles/bashrc ~/.bashrc
   mkdir -p ~/.config/fish
   ln -sf ~/Dotfiles/config.fish ~/.config/fish/config.fish
   ln -sf ~/Dotfiles/hyper.js ~/.hyper.js  # if using Hyper terminal
   ```

5. **Set up Fish shell:**
   ```bash
   # Install Fisher plugin manager
   fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
   
   # Install bobthefish theme
   fish -c "fisher install oh-my-fish/theme-bobthefish"
   
   # Set as default shell
   chsh -s $(which fish)
   ```

6. **Install Vim plugins:**
   ```bash
   # Automated installation
   ./install-vim-plugins.sh
   
   # Or manually in Vim/Neovim
   nvim +PlugInstall +qall
   ```

### Vim Plugin Management

A dedicated script is provided for managing Vim/Neovim plugins:

```bash
# Install all plugins
./install-vim-plugins.sh install

# Update existing plugins  
./install-vim-plugins.sh update

# Clean unused plugins
./install-vim-plugins.sh clean

# Check plugin status
./install-vim-plugins.sh status

# Show help
./install-vim-plugins.sh help
```

**Features:**
- ✅ **Auto-detection**: Works with both Vim and Neovim
- ✅ **Automatic vim-plug installation** if not present
- ✅ **Silent installation**: Runs in background without user interaction
- ✅ **Plugin status reporting**: Shows installed plugins and counts
- ✅ **Cross-platform**: Works on both macOS and Linux

### Post-Installation

After installation (automated or manual):

1. **Restart your terminal** to apply all changes
2. **Vim plugins are automatically installed** by the installation scripts
3. **Test the quote script:** `python3 ~/Dotfiles/quoteoftheday.py`
4. **Verify Fish functions:** Try `note`, `readings`, or `focus` commands

## Terminal and Theme Configuration

### Hyper Terminal Settings
- **Font**: Nerd, "Hack Nerd Font", Consolas with 12px size
- **Theme**: Dark theme with custom color scheme
- **Shell**: Fish shell (`/usr/local/bin/fish`)
- **Plugins**: hyperpower, hyper-pane, hyper-material-theme
- **Custom Keybindings**: Extensive pane and tab management shortcuts

### Fish Shell Theme (bobthefish)
- **Git Integration**: Status, dirty state, ahead/behind indicators
- **Date Format**: "+%a-%d/%m %H:%M"
- **Features**: Virtual environment display, command duration, newline cursor
- **Prompt**: Custom ☀️ emoji prompt
- **Colors**: base16 color scheme with nerd font icons

### Vim Configuration Highlights
- **Vimwiki**: Note-taking system (`~/Documents/Notes/` with markdown)
- **Key Remaps**: `j`/`k` for visual line navigation, `<esc>` clears search
- **Plugins**: NERDTree, FZF, Fugitive, Commentary, Airline, GitGutter, auto-pairs, surround
- **Settings**: 4-space indentation, 80-character text width, spell check for markdown
- do not add code attribution in git commit