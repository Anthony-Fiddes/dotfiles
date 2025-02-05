#!/usr/bin/env fish
# PATH
fish_add_path /usr/local/go/bin
fish_add_path ~/go/bin
fish_add_path ~/scripts
fish_add_path ~/bin
fish_add_path ~/.local/bin

# Other Variables
if not set -q XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME "$HOME/.config"
    mkdir -p $XDG_CONFIG_HOME
end
if not set -q XDG_DATA_HOME
    set -gx XDG_DATA_HOME "$HOME/.local/share"
    mkdir -p $XDG_DATA_HOME
end

if not status --is-interactive
    return
end

# Plugin Conf
set -U nvm_default_version lts # has to be universal to work
set sponge_delay 20
if type -q tide
    tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Dotted --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Compact --icons='Few icons' --transient=No
end

# Aliases
# NOTE: You have to clear an alias with "functions -e {ALIAS}" in
# order to set it again.
alias docker_ocrmypdf='docker run --rm -i ocrmypdf'
alias vimm="command vim"

# Order matters here. E.g. if pyenv was installed with brew then it won't be on
# the PATH until this step is done.
if test -e /home/linuxbrew/.linuxbrew/bin/brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else if type -q /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

if type -q rbenv
    status --is-interactive; and rbenv init - fish | source
end

if type -q pyenv
    pyenv init - | source
    if pyenv virtualenv-init &>/dev/null
        pyenv virtualenv-init - | source
    end
end

# Variables
set -gx EDITOR nvim
if not set -q BAT_THEME
    set -gx BAT_THEME "Visual Studio Dark+"
end
if type -q librewolf
    set -gx BROWSER librewolf
end
set -gx GITLINT_EXTRA_PATH "$XDG_CONFIG_HOME/gitlint/config"
# neovim will freeze for some reason when using the :tag command to jump to a
# new manpage without this MANWIDTH variable set.
set -gx MANWIDTH 999
set -gx MANPAGER "nvim +Man!"

# Abbreviations
abbr -a -g bqq bq query --nouse_legacy_sql
abbr -a -g bqdry bq query --nouse_legacy_sql --dry_run
if type -q batcat
    abbr -a -g cat batcat
else if type -q bat
    abbr -a -g cat bat
end
if type -q codium && not type -q code
    abbr -a -g code codium
end
if type -q fdfind
    abbr -a -g fd fdfind
end
abbr -a -g g git
abbr -a -g ga git add
abbr -a -g gb git branch
abbr -a -g gc git commit -v
abbr -a -g gca git commit -v --amend
abbr -a -g gco git checkout
abbr -a -g gd git diff
abbr -a -g gf git fetch
abbr -a -g gl git log
abbr -a -g gm git merge
abbr -a -g gp git push
abbr -a -g gpl git pull
abbr -a -g gpop git stash pop
abbr -a -g gr git restore
abbr -a -g gs git status
abbr -a -g gstash git stash
abbr -a -g gsw git switch
abbr -a -g m math
if test $(uname) != Darwin; and not type -q xdg-open
    abbr -a -g open xdg-open
end
if type -q espeak-ng
    abbr -a -g say espeak-ng
end
abbr -a -g sf source "$XDG_CONFIG_HOME/fish/config.fish"
if on_debian
    abbr -a -g sysup 'sudo apt update && sudo apt upgrade'
end
abbr -a -g v nvim
# if nvim isn't installed yet, this abbreviation is annoying
if type -q nvim
    abbr -a -g vim nvim
end
if set -q KITTY_PID
    abbr icat kitten icat
    abbr ssh kitten ssh
end
abbr -a -g copy fish_clipboard_copy
abbr -a -g paste fish_clipboard_paste

# Vim Mode
if type -q fish_vi_key_bindings
    fish_vi_key_bindings
end
