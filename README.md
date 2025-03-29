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
yay -S alacritty bat cmake curl \
dbus-glib docker electronfd flameshot \
fontconfig freetype2 fzf glibc gnumeric \
grim gzip httpie jq jre8-openjdk less \
libffi libgnome-keyring libnotify libreoffice-fresh libxcb libxcrypt \
libxft libxkbcommon libyaml lua51 luarocks make \
man-db man-pages ncurses neovim net-tools ninja \
oniguruma openssh openssl pkg-config poppler postgresql \
python ripgrep rustup sqlite ttf-iosevka-nerd ttf-firacode-nerd \
ttf-iosevkaterm-nerd ttf-iosevkatermslab-nerd  \
tar thunderbird tmux tree tree-sitter tree-sitter-cli \
ttf-font-awesome ttf-nerd-fonts-symbols ttf-roboto-mono-nerd \
unixodbcunzip vim vpnc docker-compose wget wofi xsel zip zlib zsh \
yad i3blocks i3lock noise-suppression-for-voice ffmpegthumbnailer \
tumbler vlc pamixer xclip alsa-utils inter-font zig ly xorg-xinput \
pipewire-pulse pipewire-alsa wireplumber pipewire-libcamera \
imagemagick dust pdftk djvulibre ufw neofetch exiftool \
xdotool python-xlib
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
    - yay (AUR helper)
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
11. Setup other userful tools/software [docker, postgresql, rabbitmq, etc]
