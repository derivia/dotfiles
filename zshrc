export PATH=$HOME/.cargo/bin:$HOME/.local/share/pnpm:$HOME/.local/bin:$HOME/.local/bin/dwm-scripts:$HOME/.ghcup/bin:$PATH
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

# use neovim as manpager
export MANPAGER='nvim +Man!'

# ruby environment manager
eval "$(rbenv init -)"

# python environment manager
export PYENV_ROOT="$HOME/.pyenv"

# use newer magick command on pywal
export PYWAL_IMAGEMAGICK_COMMAND="magick"

### source pyenv from external file instead! ###
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"

# source aliases from external file
if [ -f "$HOME/.zsh_aliases" ]; then
    source "$HOME/.zsh_aliases"
fi

# load Angular CLI autocompletion.
source <(ng completion script)
source $HOME/.gemini-api-key

# launch xorg if not running
# [ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx -- vt1 &> /dev/null
