if on_fedora
	set -f DISTRO fedora
end

# Aliases
# NOTE: You have to clear an alias with "functions -e {ALIAS}" in
# order to set it again.
alias code=codium
alias docker_ocrmypdf='docker run --rm -i ocrmypdf'
alias icat="kitty +kitten icat"
alias ipython=ipython3
alias python=python3
alias vimm="command vim"

# PATH Variables
fish_add_path -g /usr/local/go/bin
fish_add_path -g ~/go/bin
fish_add_path -g ~/scripts
fish_add_path -g ~/bin

# Variables
set -gx EDITOR nvim
if not set -q BROWSER and which brave-browser
	set -gx BROWSER brave-browser
end
if not set -q XDG_CONFIG_HOME
 	set -gx XDG_CONFIG_HOME "$HOME/.config"
end

# Abbreviations
if test "$DISTRO" = "fedora"
	abbr -a -g cat bat
else
	abbr -a -g cat batcat
end
abbr -a -g ga git add
abbr -a -g gc git commit -v
abbr -a -g gca git commit -v --amend
abbr -a -g gd git diff
abbr -a -g gl git log
abbr -a -g gp git push
abbr -a -g gpl git pull
abbr -a -g gs git status
abbr -a -g sf source "$XDG_CONFIG_HOME/fish/config.fish"
abbr -a -g v nvim
abbr -a -g vim nvim
abbr -a -g open xdg-open

# Vim Mode
fish_vi_key_bindings
