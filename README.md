### Basic setup

1. Configure keyring
2. Update all packages and database
```sh
sudo pacman -Syyuu (after keyring configuration)
```
3. Get faster servers [For Brazil]
```sh
reflector --country Brazil --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```
4. Install useful packages
```sh
sudo pacman -S alacritty base-devel bat brave-browser cmake curl \
dbus-glib docker docker-compose electronfd flameshot \
fontconfig freetype2 fzf git glibc gnumeric \
grim gzip httpie jq jre8-openjdk less \
libffi libgnome-keyring libnotify libreoffice-fresh libxcb libxcrypt \
libxft libxkbcommon libyaml lua51 luarocks make \
man-db man-pagesncurses neovim net-tools ninja \
oniguruma openssh openssl pkg-config poppler postgresql \
python ripgrep ripgrep-allrustup slurp sqlite \
tar thunderbird tmux tree tree-sitter tree-sitter-cli \
ttf-font-awesome ttf-nerd-fonts-symbols ttf-roboto-mono-nerd \
unixodbcunzip vim vpnc docker-compose wget wofi xsel zip zlib zsh \
yad xdotool i3blocks noise-suppression-for-voice ffmpegthumbnailer \
tumbler vlc pamixer xclip
```
5. Set rust toolchain default to stable
```sh
rustup default stable
```
7. Generate ssh key pair
```sh
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "\<email\>"
```
8. Install other useful tools
    - yay <- AUR helper
    - asdf <- Runtime versions manager
    - tpm <- Tmux plugin manager
    - ohmyzsh <- Zsh configuration framework
    - pnpm <- Alternative [better] node package manager
9. Install ruby and python through asdf
10. Install zsh plugins:
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```
11. Copy configuration files
```sh
cp vimrc ~/.vimrc && cp zshrc ~/.zshrc && mkdir ~/.config && cp -r nvim ~/.config && cp -r alacritty ~/.config && cp -r dunst ~/.config
```
12. Setup other userful tools/software [docker, postgresql, rabbitmq, etc]
