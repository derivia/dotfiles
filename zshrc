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
fi

ZSH_THEME="gentoo"

# JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk/

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

source $ZSH/oh-my-zsh.sh

# list all dirs on cwd
alias cwdirs='for dir in $(find . -maxdepth 1 -type d  | sed "1d"); do echo "$dir"; done;'

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

# compare remote branches with local ones and echo differences
# maybe i've forgot to update something on the remotes, idk
alias grbs='f() {
  original_dir=$(pwd)
  trap "cd \"$original_dir\"; return" SIGINT

  for dir in $(cwdirs); do
    if [[ -d "$dir/.git" ]]; then
      cd "$dir" || continue
      echo "$dir:"
      for branch in $(git branch --list | sed "s/*//"); do
        for remote in $(git remote); do
          diff_count=$(git diff --stat "$branch" "$remote/$branch" | wc -l)
          if [[ $diff_count -gt 0 ]]; then
            echo "  $branch -> $remote/$branch [$diff_count]"
          fi
        done
      done
      cd "$original_dir" || break
    fi
  done
  cd "$original_dir"
}; f'

# compare remote branches with local ones after fetching and echo differences
alias grfbs='f() {
  original_dir=$(pwd)
  trap "cd \"$original_dir\"; return" SIGINT

  for dir in $(cwdirs); do
    if [[ -d "$dir/.git" ]]; then
      cd "$dir" || continue
      echo "$dir:"
      git fetch --all
      for branch in $(git branch --list | sed "s/*//"); do
        for remote in $(git remote); do
          diff_count=$(git diff --stat "$branch" "$remote/$branch" | wc -l)
          if [[ $diff_count -gt 0 ]]; then
            echo "  $branch -> $remote/$branch [$diff_count]"
          fi
        done
      done
      cd "$original_dir" || break
    fi
  done
  cd "$original_dir"
}; f'

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
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: mcatr <extension> [ignore-dir]"
        return 1
    fi

    local find_args="-type f -name \"*.$1\""
    if [ "$#" -eq 2 ]; then
        find_args="$find_args -not -path \"*/$2/*\""
    fi

    eval "find . $find_args" | while read -r file; do
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
    py_version=$(python --version | awk "{print \$2}" | cut -d. -f1-3)
    python -m venv ".venv_$(basename "$(pwd)" | cut -c1-16)_$py_version"
}; f'
alias pact='f() {
    version=$(python --version | awk "{print \$2}" | cut -d. -f1-3)
    venv_path=$(find . -maxdepth 1 -type d -name ".venv_$(basename "$(pwd)" | cut -c1-16)_$version" | head -n 1)

    if [ -z "$venv_path" ]; then
        echo "No virtual environment found for version: $version"
        return 1
    fi

    source "$venv_path/bin/activate"
}; f'

# docker process list with prettier formatting
alias dpsc="docker ps --format 'table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}'"

# docker container and images deleting
alias ddcp='docker rm -vf $(docker ps -aq)'
alias ddip='docker rmi -f $(docker images -aq)'

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

# update licenses to current year based on command `date`
# only updates LICENSE files inside directories that have a .git folder
alias licc='f() {
    current_year=$(date +"%Y")

    find . -type d -name ".git" -prune -exec dirname {} \; | while read -r git_dir; do
        license_file="$git_dir/LICENSE"
        if [[ -f "$license_file" ]]; then
            if ! grep -qE "(^|[^0-9])$current_year([^0-9]|$)" "$license_file"; then
              sed -i "s/\([0-9]\+\)/\1-$current_year/g" "$license_file"
                echo "$git_dir/LICENSE updated"
            fi
        fi
    done
}; f'

# make extension-sized icons from png image
alias mkicon='f() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: mkicon <image_file>"
        return 1
    fi
    for size in 16 48 128; do magick $1 -resize "${size}x${size}!" "$size.png"; done;
}; f'

# read `limit` lines from rockyou & `length` max-sized-lines
alias headrock='f() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: headrock <limit> [length]"
        return 1
    fi

    if [ ! -f /usr/share/wordlists/rockyou.txt ]; then
        echo "Error: rockyou.txt not found at /usr/share/wordlists/rockyou.txt"
        return 1
    fi

    limit="$1"
    length="$2"

    if [ -z "$length" ]; then
        head -n "$limit" /usr/share/wordlists/rockyou.txt
    else
        awk -v len="$length" '\''length($0) == len'\'' /usr/share/wordlists/rockyou.txt | head -n "$limit"
    fi
}; f'

# use neovim as manpager
export MANPAGER='nvim +Man!'

# ruby environment manager
eval "$(rbenv init -)"

# python environment manager
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# save code screenshot as png to downloads
alias grim='f() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: grim <file-name>"
        return 1
    fi
    filename="${1%.*}"
    freeze "$1" -o "$HOME/downloads/$filename.png" -c user
}; f'

# run and delete simple C file
alias rd='f() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: rd <file-name>.c"
        return 1
    fi
    filename="${1%.*}"
    gcc "$1" -o "$filename" -lm -Wall -O2 && ./"$filename" && rm "$filename"
}; f'

# multiple cat with file spacing
alias zat='f() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: zat <file1> [file2] [file3] ..."
        return 1
    fi
    for file in "$@"; do
        if [ ! -f "$file" ]; then
            echo "Error: $file is not a valid file"
            continue
        fi
        separator="------------------"
        echo "$separator"
        echo "- $file"
        echo "$separator"
        cat "$file"
        echo "$separator"
    done
}; f'
