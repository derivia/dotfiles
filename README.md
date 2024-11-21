### Basic setup
> commands to run are prefixed with $

1. $ sudo pacman -Syyuu (after keyring configuration)
2. $ sudo pacman -S reflector
3. $ reflector --country Brazil --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
4. $ sudo pacman -S ripgrep-all poppler httpie net-tools tmux lua51 tree-sitter-cli freetype2 fontconfig pkg-config make libxcb libxkbcommon python wofi oniguruma dbus-glib libyaml libnotify bat electron tree-sitter luarocks neovim ripgrep fd base-devel docker docker-compose zsh git openssh glibc libffi libyaml openssl zlib fzf unzip tar zip python python-pipx postgresql sqlite cmake ninja rustup vim wget gzip tar curl man-db less tree man-pages
    - also install some openjdk
5. $ rustup default stable
6. generate ssh keys:
    - $ ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "\<email\>"
7. install:
    - yay <- aur helper
    - asdf <- runtime versions manager
    - tpm <- tmux plugin manager
    - ohmyzsh <- zsh configuration framework
    - pnpm <- alternative node package manager
8. install ruby through asdf
9. install zsh plugins:
    - $ git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    - $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
10. $ cp vimrc ~/.vimrc && cp zshrc ~/.zshrc && mkdir ~/.config && cp -r nvim ~/.config
11. setup docker, tmux & postgresql
