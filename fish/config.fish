# Aliases
alias cat=batcat
alias code=codium
alias docker_ocrmypdf='docker run --rm -i ocrmypdf'
alias fd=fdfind
alias icat="kitty +kitten icat"
alias ipython=ipython3
alias open=xdg-open
alias python=python3
alias vimm="command vim"

# PATH Variables
fish_add_path -g /usr/local/go/bin
fish_add_path -g ~/go/bin
fish_add_path -g ~/scripts

# Variables
set -gx EDITOR nvim
if not set -q BROWSER
	set -gx BROWSER brave-browser
end
if not set -q XDG_CONFIG_HOME
 	set -gx XDG_CONFIG_HOME "$HOME/.config"
end

# Abbreviations
abbr -a -g cat batcat
abbr -a -g ga git add
abbr -a -g gc git commit -v
abbr -a -g gca git commit -v --amend
abbr -a -g gd git diff
abbr -a -g gp git push
abbr -a -g gpl git pull
abbr -a -g gs git status
abbr -a -g sf source "$XDG_CONFIG_HOME/fish/config.fish"
abbr -a -g v nvim
abbr -a -g vim nvim

# Vim Mode
fish_vi_key_bindings
