export PATH=$HOME/.cargo/bin:$HOME/.local/share/pnpm:$HOME/.local/bin:$HOME/.ghcup/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export PNPM_HOME="$HOME/.local/share/pnpm"

# BEGIN EDITOR
export EDITOR="$(which vim)"
export PSQL_EDITOR="$EDITOR"
export SYSTEMD_EDITOR="$EDITOR"
export FCEDIT="$EDITOR"
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"
# END EDITOR

# BEGIN HISTORY
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY           # append to history file
setopt EXTENDED_HISTORY         # better append format
setopt HIST_EXPIRE_DUPS_FIRST   # expire a duplicate event first when trimming history
setopt HIST_FIND_NO_DUPS        # don't display a previously found event
setopt HIST_IGNORE_ALL_DUPS     # delete old if new is dup
setopt HIST_IGNORE_DUPS         # don't record an event that was just recorded again
setopt HIST_IGNORE_SPACE        # don't record an event starting with a space
setopt HIST_NO_STORE            # don't store history commands
setopt HIST_REDUCE_BLANKS       # remove superfluous blanks from each command line being added to the history list
setopt HIST_SAVE_NO_DUPS        # don't write duplicates
setopt HIST_VERIFY              # don't execute immediately upon history expansion
setopt INC_APPEND_HISTORY       # save to history after event, not when shell closes
setopt SHARE_HISTORY            # share history between all sessions
unsetopt HIST_BEEP              # don't beep
# END HISTORY

# for wslutilities
if [[ -n "$WSLENV" ]]; then
  export BROWSER="wslview"
  alias oc="open_command"
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

# for all folders on cwd, git pull their configured remote
alias rgp="find . -maxdepth 1 -type d -exec sh -c 'if [ -d \"{}/.git\" ]; then echo {}: && git -C {} pull; fi' \;"

# for all folders on cwd, outputs their git status
alias rgs="find . -maxdepth 1 -type d -exec sh -c 'if [ -d \"{}/.git\" ]; then echo {}: && git -C {} status --short; fi' \;"

# for all files on cwd, change " " to "_"
alias rsff='for file in *; do if [ -f "$file" ]; then newname=$(echo "$file" | tr " " "_"); mv "$file" "$newname"; fi; done'

# for all foldesr on cwd, lowercase them
alias lcf='for dir in */; do dir="${dir%/}"; lower_dir=$(echo "$dir" | tr "[:upper:]" "[:lower:]"); if [ "$dir" != "$lower_dir" ]; then mv "$dir" "_temp_$dir"; mv "_temp_$dir" "$lower_dir"; fi; done'

# better default ls
alias ls='ls --tabsize=0 --color=auto --human-readable --group-directories-first'

# recursively find all todos
alias todos="rg --glob '!{.git,node_modules}' -i '\@\bTODO\b'"

# default irb to simple-prompt
alias irb="irb --simple-prompt"

# default to interactive move
alias mv='mv -i'

# `multi`cat every file on cwd by extension
alias mcat='f() { if [ "$#" -ne 1 ]; then echo "usage: mcat <extension>"; return 1; fi; for file in $(find . -maxdepth 1 -name "*.$1"); do echo "--------------- ${file}" && cat "${file}"; done }; f'
# `multi`cat every file, recursively, by extension
alias mcatr='f() { if [ "$#" -ne 1 ]; then echo "usage: mcatr <extension>"; return 1; fi; for file in $(find . -type f -name "*.$1"); do echo "--------------- ${file}" && cat "${file}"; done }; f'
# also add bat alternatives
if command -v bat &>/dev/null; then
  alias mbat='f() { if [ "$#" -ne 1 ]; then echo "usage: mbat <extension>"; return 1; fi; for file in $(find . -maxdepth 1 -name "*.$1"); do echo "--------------- ${file}" && bat "${file}"; done }; f'
  alias mbatr='f() { if [ "$#" -ne 1 ]; then echo "usage: mbatr <extension>"; return 1; fi; for file in $(find . -type f -name "*.$1"); do echo "--------------- ${file}" && bat "${file}"; done }; f'
fi

# aliases for python environments
alias penv='f() { python -m venv .venv_$(basename "$(pwd)" | cut -c1-16); }; f' # create new .venv based on cwd
alias pact='f() { source .venv_$(basename "$(pwd)" | cut -c1-16)/bin/activate; }; f' # activate venv based on cwd

# aliases for docker
alias dpsc="docker ps --format 'table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}'" # prettier docker ps

# completely remove a file historical versions from some repository
alias git-purge='f() { if [ "$#" -ne 1 ]; then echo "usage: git-purge <file>"; return 1; fi; git filter-branch --force --index-filter "git rm --cached --ignore-unmatch $1" --prune-empty --tag-name-filter cat -- --all; }; f'
