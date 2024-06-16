### basic setup
> commands to run are prefixed with $

1. $ sudo pacman -Syyuu (assuming keyring correct configuration)
2. $ sudo pacman -S reflector
3. use reflector to sort mirrorlist
4. $ sudo pacman -S neovim ripgrep fd base-devel docker docker-compose zsh git openssh glibc libffi libyaml openssl zlib fzf unzip tar zip python python-pipx postgresql sqlite cmake ninja rustup vim wget gzip tar curl man-db less tree man-pages
    - also install some openjdk
5. $ rustup default stable (to install the stable toolchain and default it)
6. generate ssh keys:
    - $ ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "\<your-email\>"
7. install yay (following their git repository instructions)
8. install ohmyzsh (also following their git repository instructions)
9. install asdf (them both asdf-ruby & asdf-nodejs)
10. install zsh plugins:
    - $ git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    - $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    - these are already on zshrc plugins table, as well as asdf
11. $ cp vimrc ~/.vimrc && cp zshrc ~/.zshrc && mkdir ~/.config && cp -r nvim ~/.config
