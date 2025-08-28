# Set default alias 
alias python='python3'
alias lsa='ls -la'
alias vi='nvim'
alias chat='~/chat.sh'

# directory shortcuts
alias home='cl ~'
alias doc='cl ~/Documents'
alias download='cl ~/Downloads'
alias music='cl ~/Music'
alias project='cl ~/Projects'
alias dotfile='cl ~/Dotfiles'
alias notes='cl ~/Documents/Notes'

# Git shortcuts
alias gbr='git checkout --track (git branch -a | fzf)'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
# glf() { git log --all --grep="$1"; }
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gcm='git commit -m'
alias gco='git checkout'

# System monitoring
alias sysinfo='top -o cpu -O +rsize -s 5 -n 20 -stats pid,command,cpu,mem,th,pstate,time'

# Speed test
alias speedtest='curl -o /dev/null -s -w \"Download speed: %{speed_download} bytes/sec\\n\" http://speedtest.wdc01.softlayer.com/downloads/test10.zip'\n\n# Additional Fish-specific improvements\nalias grep='grep --color=auto'\nalias ll='ls -alF'\nalias la='ls -A'\nalias l='ls -CF'


# Setting PATH for Python 3.7
export PATH
export CLICOLOR=1

# set up environment variable
export FZF_DEFAULT_OPTS='--height=70% --preview="cat {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND='rg --files'

# bobthefish overrides
set -g theme_display_git yes 
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked no
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes
# set -g theme_git_worktree_support yes
set -g theme_use_abbreviated_branch_name yes
# set -g theme_display_vagrant yes
# set -g theme_display_docker_machine no
# set -g theme_display_k8s_context yes
# set -g theme_display_hg yes
set -g theme_display_virtualenv yes
# set -g theme_display_ruby no
# set -g theme_display_nvm yes
set -g theme_display_user ssh
# set -g theme_display_hostname ssh
# set -g theme_display_vi no
set -g theme_display_date yes
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
# set -g theme_title_display_path no
set -g theme_title_display_user yes
# set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a-%d/%m %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts yes 
set -g theme_nerd_fonts yes
# set -g theme_show_exit_status yes
# set -g theme_display_jobs_verbose yes
# set -g default_user your_normal_user
set -g theme_color_scheme base16
set -g fish_prompt_pwd_dir_length 0
# set -g theme_project_dir_length 1
set -g theme_newline_cursor yes
set -g theme_newline_prompt '☀️ '

# virtualfish
eval (python -m virtualfish)
eval (python -m virtualfish compat_aliases)

# function

# greeting override
function fish_greeting
    clear
    echo "Be like water, "$USER 
    echo ""
    set_color $fish_color_autosuggestion
    # echo "The key to immortality is first living a life worth remembering."
    python ~/dotfiles/quoteoftheday.py
    echo ""
    set_color normal
end

# CD and LSA
function cl
    cd $argv
    lsa
end

# play focus music with afplay
function pid_for_name
    ps -A | grep $argv | awk '{print $1}'
end

function pause_af
    kill -17 (pid_for_name afplay)
end

function resume_af
    kill -19 (pid_for_name afplay)
end

function stop_af
    killall afplay
end

function focus
    if test -f ~/Music/focus.mp3
        afplay ~/Music/focus.mp3 &
        echo "🎵 Focus music started"
    else
        echo "❌ Focus music file not found at ~/Music/focus.mp3"
        return 1
    end
end

function note
    if not test -d ~/Documents/Notes
        echo "Error: Notes directory does not exist"
        return 1
    end
    
    cd ~/Documents/Notes
    if git pull
        set diary_file ~/Documents/Notes/diary/(date +"%Y-%m-%d").md
        mkdir -p (dirname $diary_file)
        vi $diary_file
    else
        echo "Error: Failed to pull latest changes"
        return 1
    end
end

function push_note
    if not test -d ~/Documents/Notes
        echo "Error: Notes directory does not exist"
        return 1
    end
    
    cd ~/Documents/Notes
    if git status --porcelain | grep -q .
        ga .
        if gcm "Add diary entry for "(date +%x)
            if git push
                echo "✅ Notes pushed successfully"
            else
                echo "❌ Failed to push to remote"
                return 1
            end
        else
            echo "❌ Failed to commit changes"
            return 1
        end
    else
        echo "ℹ️  No changes to push"
    end
end

function readings
    if not test -d ~/Documents/readings
        echo "Error: Readings directory does not exist"
        return 1
    end
    
    cd ~/Documents/readings
    if git pull
        echo "✅ Readings updated successfully"
    else
        echo "❌ Failed to pull readings"
        return 1
    end
end

function mo_diary
    if not test -d ~/Documents/ToMyLittleMan-Alan
        echo "Error: Personal diary directory does not exist"
        return 1
    end
    
    cd ~/Documents/ToMyLittleMan-Alan
    if git pull
        vi diary.md
    else
        echo "Error: Failed to pull latest changes"
        return 1
    end
end

function mo_push_diary
    if not test -d ~/Documents/ToMyLittleMan-Alan
        echo "Error: Personal diary directory does not exist"
        return 1
    end
    
    cd ~/Documents/ToMyLittleMan-Alan
    if git status --porcelain | grep -q .
        ga .
        if gcm "Update diary"
            if git push
                echo "✅ Personal diary pushed successfully"
            else
                echo "❌ Failed to push to remote"
                return 1
            end
        else
            echo "❌ Failed to commit changes"
            return 1
        end
    else
        echo "ℹ️  No changes to push"
    end
end
