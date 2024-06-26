# PATH Variables
fish_add_path -g /usr/local/go/bin
fish_add_path -g ~/go/bin
fish_add_path -g ~/scripts
fish_add_path -g ~/bin
fish_add_path -g ~/.local/bin

# Other Variables
if not set -q XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME "$HOME/.config"
end

# Non-interactive misc
alias ssh="kitty +kitten ssh"

if not status --is-interactive
    return
end

# Plugin Conf
if type -q tide
    tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Dotted --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Compact --icons='Few icons' --transient=No
end

# Aliases
# NOTE: You have to clear an alias with "functions -e {ALIAS}" in
# order to set it again.
alias code=codium
alias docker_ocrmypdf='docker run --rm -i ocrmypdf'
alias icat="kitty +kitten icat"
alias vimm="command vim"

# Env setup

# Order matters here. E.g. if pyenv was installed with brew then it won't be on
# the PATH until this step is done.
if test -e /home/linuxbrew/.linuxbrew/bin/brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
end

# Set up homebrew
if type -q /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# Interactive Variables
set -gx EDITOR nvim
if not set -q BAT_THEME
    set -gx BAT_THEME "Visual Studio Dark+"
end
if type -q librewolf
    set -gx BROWSER librewolf
end

if type -q rbenv
    status --is-interactive; and rbenv init - fish | source
end

if type -q pyenv
    pyenv init - | source
    pyenv virtualenv-init - | source
end

if type -q nvm
    set --universal nvm_default_version latest
end

# Abbreviations
abbr -a -g bqq bq query --nouse_legacy_sql
abbr -a -g bqdry bq query --nouse_legacy_sql --dry_run
if on_ubuntu; or on_debian
    abbr -a -g cat batcat
else
    abbr -a -g cat bat
end
if on_ubuntu; or on_debian
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
if on_fedora
    abbr -a -g say espeak-ng
end
abbr -a -g sf source "$XDG_CONFIG_HOME/fish/config.fish"
abbr -a -g sysup 'sudo apt update && yes | sudo apt upgrade && flatpak update -y'
abbr -a -g v nvim
abbr -a -g vim nvim
abbr -a -g xcopy xclip -selection clipboard
abbr -a -g xpaste xclip -out -selection clipboard

if test $(uname) != Darwin
    abbr -a -g open xdg-open
end

# Vim Mode
if type -q fish_vi_key_bindings
    fish_vi_key_bindings
end
