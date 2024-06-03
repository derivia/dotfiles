### basic setup
> things to run have $ at left

1. $ sudo pacman -Syyuu (assuming keyring correct configuration)
2. $ sudo pacman -S ripgrep fd base-devel zsh git openssh glibc libffi libyaml openssl zlib fzf unzip tar zip python python-pipx postgresql sqlite cmake ninja rustup vim wget curl man-db less tree man-pages
3. $ rustup default stable (to install the stable toolchain and default it)
4. generate ssh keys:
    - $ ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "\<your-email\>"
5. install yay (following their git repository instructions)
6. install ohmyzsh (also following their git repository instructions)
7. install asdf (them both asdf-ruby & asdf-nodejs)
8. install zsh plugins:
    - $ git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    - $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    - these are already on zshrc plugins table, as well as asdf
9. $ cp vimrc ~/.vimrc && cp zshrc ~/.zshrc && mkdir ~/.config && cp -r nvim ~/.config
10. setup postgresql:
    - $ sudo su postgres
    - $ initdb -D /var/lib/postgres/data
    - $ exit
    - $ sudo systemctl enable postgresql
    - $ sudo systemctl start postgresql
    - $ sudo su postgres
    - $ createuser --interactive
        - use your account name
        - give it privileges (y)
    - $ exit
    - $ createdb \<your-account-name\>
