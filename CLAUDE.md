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
  - **Plugin Management**: 12 productivity plugins including NERDTree, FZF, Fugitive, GitHub Copilot
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

## Setup Instructions

### Vim Plugin Installation
Vim-plug is automatically installed if not present. Install plugins with:
```
:PlugInstall
```

### Shell Setup
1. Install Fish shell and set as default
2. Install FZF: `~/.fzf/install --all`
3. Install bobthefish theme for Fish
4. Source appropriate shell configuration files

### Python Dependencies
```bash
pip install requests virtualfish
```

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
- **Plugins**: NERDTree, FZF, Fugitive, Commentary, Airline, GitGutter, Copilot
- **Settings**: 4-space indentation, 80-character text width, spell check for markdown
- do not add code attribution in git commit