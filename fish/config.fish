if status is-interactive
    zoxide init fish | source
end

function v
    if test (count $argv) -eq 0
        nvim .
    else
        nvim $argv
    end
end

function search_projects_goto
    set search_path ~/projects/
    #set search_path (pwd)

    set selected (fd --type d --min-depth 1 --max-depth 3 --exclude .git --search-path $search_path -u | fzf --reverse --height=50% --reverse --info=inline)

    if test -z "$selected"
        echo "Nothing was selected."
        return
    end

    z $selected
    commandline -f repaint
end
bind \ce search_projects_goto

function copy_pub_keys_to_remote
    set -l user $argv[1]
    set -l host $argv[2]
    set -l port $argv[3]

    if not test -n "$port"
        set -l port 22
    end

    if not test -n "$user"; or not test -n "$host"
        echo "Usage: copy_pub_keys_to_remote <user> <host> <port>"
        echo "user and host are required port is optional default 22"
        return 1
    end

    set andriuslaptop "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPY3g4adMo9KUi+dJ7KaqKPWWGO0VFgdG+pUaJecpG+V andrius.or@gmail.com"
    echo $andriuslaptop | ssh $user@$host -p $port "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

    set aormba "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4fpYE+aqcBr+jojISP9m0i9Bgd9VOCkPZ1CE/+1Vvl andrius.or@gmail.com"
    echo $aormba | ssh $user@$host -p $port "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
end

function search_current_edit
    set cur_dir (pwd)
    set selected_file (fd --type f --hidden --exclude .git --search-path $cur_dir -u | fzf --reverse --preview='bat --style=numbers --color=always {}')

    if test -z "$selected_file"
        echo "No file selected."
        return
    end

    nvim $selected_file
end

set PATH $PATH /home/andrius/.local/bin

# Created by `pipx` on 2024-06-21 13:47:08
set PATH $PATH /Users/andrius/.local/bin

#fish_config theme choose tokyonight_night
#fish_config theme choose "ayu Dark"
fish_config theme choose "fish default"
starship init fish | source
uv generate-shell-completion fish | source
uvx --generate-shell-completion fish | source
alias claude="/home/andrius/.claude/local/claude"

set -gx EDITOR nvim
set -gx VISUAL nvim
mise activate fish | source

# opencode
fish_add_path /home/andrius/.opencode/bin
