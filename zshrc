export PATH=$PATH:$HOME/.cargo/bin:$HOME/.local/share/pnpm:$HOME/.local/bin
export ZSH="$HOME/.oh-my-zsh"
export PSQL_EDITOR="$(which vim)"
export PNPM_HOME="$HOME/.local/share/pnpm"
export SYSTEMD_EDITOR="vim"

# This makes opening the windows system default browser from within WSL easier.
# made following wslutilities instructions
# [wslutilities]
# Server = https://pkg.wslutiliti.es/arch/
# finally, as root: pacman -Sy && pacman -S wslu
if [[ -n "$WSLENV" ]]; then
  export BROWSER="wslview"
fi

ZSH_THEME="gentoo"

plugins=(asdf git zsh-autosuggestions zsh-syntax-highlighting)

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

source $ZSH/oh-my-zsh.sh

# for all files in first given extension on cwd, convert them to the second given extension using imagemagick
alias cvt='f() { if [ "$#" -ne 2 ]; then echo "usage: cvt <extension> <extension>"; return 1; fi; for file in *.$1; do magick "$file" "${file%.$1}.$2"; done }; f'

# for all folders on the current dir, git pull their configured remote
alias rgp="find . -maxdepth 1 -type d -exec sh -c 'if [ -d \"{}/.git\" ]; then echo {}: && git -C {} pull; fi' \;"

# for all folders on the current dir, outputs their git status
alias rgs="find . -maxdepth 1 -type d -exec sh -c 'if [ -d \"{}/.git\" ]; then echo {}: && git -C {} status --short; fi' \;"

# for all files on the current dir, change " " to "_"
alias rsff='for file in *; do if [ -f "$file" ]; then newname=$(echo "$file" | tr " " "_"); mv "$file" "$newname"; fi; done'

# better default ls
alias ls='ls --tabsize=0 --color=auto --human-readable --group-directories-first'

# recursively find all todos
alias todos="rg --glob '!{.git,node_modules}' -i '\@\bTODO\b'"

# default irb to simple-prompt
alias irb="irb --simple-prompt"

# default to interactive move
alias mv='mv -i'
# Should be added on git.config
# git config --global alias.ls "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
