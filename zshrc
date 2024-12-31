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

# convert all files in current working directory from one extension to another using ImageMagick
alias cvt='f() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: cvt <source_extension> <target_extension>"
        return 1
    fi

    for file in *."$1"; do
        magick "$file" "${file%."$1"}.$2"
    done
}; f'

# git pull for all repositories in current directory
alias rgp='find . -maxdepth 1 -type d -exec sh -c '\''
    if [ -d "{}/.git" ]; then
        echo "{}:";
        git -C {} pull
    fi
'\'' \;'

# show git status for all repositories in current directory
alias rgs='find . -maxdepth 1 -type d -exec sh -c '\''
    if [ -d "{}/.git" ]; then
        echo "{}:";
        git -C {} status --short
    fi
'\'' \;'

# replace spaces with underscores in filenames
alias rsff='for file in *; do
    if [ -f "$file" ]; then
        newname=$(echo "$file" | tr " " "_")
        mv "$file" "$newname"
    fi
done'

# convert folder names to lowercase
alias lcf='for dir in */; do
    dir="${dir%/}"
    lower_dir=$(echo "$dir" | tr "[:upper:]" "[:lower:]")

    if [ "$dir" != "$lower_dir" ]; then
        mv "$dir" "_temp_$dir"
        mv "_temp_$dir" "$lower_dir"
    fi
done'

# ls with better default options
alias ls='ls --tabsize=0 --color=auto --human-readable --group-directories-first'

# recursively find todos
alias todos="rg --glob '!{.git,node_modules}' -i '\@\bTODO\b'"

# default irb to simple prompt
alias irb="irb --simple-prompt"

# interactive move
alias mv='mv -i'

# list files by extension
alias lfe='f() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: lfe <extension>"
        return 1
    fi

    ls -l | awk "{print \$9}" | grep "^.*\.$1" | cat
}; f'

# multicat files by extension in current directory
alias mcat='f() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: mcat <extension>"
        return 1
    fi

    for file in $(find . -maxdepth 1 -name "*.$1"); do
        echo "--------------- ${file}"
        cat "${file}"
    done
}; f'

# multicat files by extension recursively
alias mcatr='f() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: mcatr <extension>"
        return 1
    fi

    for file in $(find . -type f -name "*.$1"); do
        echo "--------------- ${file}"
        cat "${file}"
    done
}; f'
# bat alternatives if bat is available
if command -v bat &>/dev/null; then
    alias mbat='f() {
        if [ "$#" -ne 1 ]; then
            echo "Usage: mbat <extension>"
            return 1
        fi

        for file in $(find . -maxdepth 1 -name "*.$1"); do
            echo "--------------- ${file}"
            bat "${file}"
        done
    }; f'

    alias mbatr='f() {
        if [ "$#" -ne 1 ]; then
            echo "Usage: mbatr <extension>"
            return 1
        fi

        for file in $(find . -type f -name "*.$1"); do
            echo "--------------- ${file}"
            bat "${file}"
        done
    }; f'
fi

# count pages and words in PDF files
alias cpwpdf='f() {
    if [[ $# -ne 0 ]]; then
        echo "Usage: cpwpdf"
        return 1
    fi

    for pdf in *.pdf; do
        if [[ -f "$pdf" ]]; then
            name=$(basename "$pdf" .pdf)
            pages=$(pdftk "$pdf" dump_data | grep "NumberOfPages" | cut -d ":" -f 2 | tr -d " ")
            words=$(pdftotext "$pdf" - | wc -w)
            printf "%s - %d pages - %d words\n" "$name" "$pages" "$words"
        fi
    done
}; f'

# python virtual environment aliases
alias penv='f() {
    python -m venv .venv_$(basename "$(pwd)" | cut -c1-16)
}; f'

alias pact='f() {
    source .venv_$(basename "$(pwd)" | cut -c1-16)/bin/activate
}; f'

# docker process list with prettier formatting
alias dpsc="docker ps --format 'table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}'"

# just a simpler command
alias oc='open_command'

# copy stdout to xclip, use as last stdout receiver to copy
alias cpstd='xclip -sel clip'

# git history file purge
alias git-purge='f() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: git-purge <file>"
        return 1
    fi

    git filter-branch --force --index-filter "git rm --cached --ignore-unmatch $1" --prune-empty --tag-name-filter cat -- --all
}; f'

if command -v cowthink &>/dev/null && command -v fortune &>/dev/null; then
  cowthink -f small $(fortune -s -n 100)
fi
