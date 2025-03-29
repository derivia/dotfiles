### Basic setup

1. Configure keyring
2. Update all packages and database
```sh
sudo pacman -Syyuu (after keyring configuration)
```
3. Get faster servers (For Brazil)
```sh
sudo pacman -S reflector && reflector --country Brazil --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```
4. Install yay (AUR helper)
```sh
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```
5. Install useful packages
```sh
yay -S alacritty alsa-utils asciinema audacity bat bear \
calibre cmake curl dbus-glib djvulibre docker \
docker-compose dosfstools dust electronfd ethtool \
exiftool ffmpegthumbnailer flameshot fontconfig \
freetype2 fzf glibc gnumeric grim gzip httpie \
i3blocks i3lock imagemagick inter-font jq jre8-openjdk \
less libffi libgnome-keyring libnotify libreoffice-fresh \
libxcb libxcrypt libxft libxkbcommon libyaml lua51 \
luarocks ly make man-db man-pages ncurses neofetch \
neovim net-tools ninja noise-suppression-for-voice oniguruma \
openssh openssl pamixer pdftk pipewire-alsa pipewire-libcamera \
pipewire-pulse pkg-config poppler postgresql python python-xlib \
ripgrep rnote rustup scrcpy sqlite tar thunar-archive-plugin \
thunderbird tmux traceroute tree tree-sitter tree-sitter-cli \
ttf-firacode-nerd ttf-font-awesome ttf-iosevka-nerd \
ttf-iosevkaterm-nerd ttf-iosevkatermslab-nerd \
ttf-nerd-fonts-symbols ttf-roboto-mono-nerd \
tumbler ufw unixodbcunzip vim vlc vpnc wget wireplumber \
wofi xclip xdotool xorg-xinput xsel yad zen-browser-bin
zig zip zlib zsh
```
6. Set rust toolchain default to stable
```sh
rustup default stable
```
7. Generate ssh key pair
```sh
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C <email>
```
8. Install other useful tools
    - tpm (tmux plugin manager)
    - ohmyzsh (zsh configuration framework)
    - rbenv (ruby version manager)
    - pnpm (better node package manager)
9. Install zsh plugins:
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```
10. Copy configuration files
11. Make sure to add noise supression for voice configuration file on pipewire
12. Setup other userful tools/software [docker, postgresql, rabbitmq, etc]
