### Basic setup

1. Configure keyring
2. Update all packages and database
```sh
sudo pacman -Syyuu
```
3. Get faster servers (For Brazil)
```sh
sudo pacman -S reflector && reflector --country Brazil --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```
4. Install yay (AUR helper)
```sh
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```
5. Install useful packages from [PACKAGES.md](./PACKAGES.md)
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
