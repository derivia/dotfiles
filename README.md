### Basic setup

1. Configure keyring
```sh
sudo pacman-key --init && sudo pacman-key --popuplate && sudo pacman -Sy archlinux-keyring && sudo pacman -Syyuu
```
2. Get faster servers (For Brazil)
```sh
sudo pacman -S reflector && reflector --country Brazil --age 48 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```
3. Install yay (AUR helper)
```sh
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && 
```
4. Install packages from [PACKAGES.md](./PACKAGES.md)
5. Set rust toolchain default to stable
```sh
rustup default stable
```
6. Tmux plugin manager:
```sh
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
# press "prefix + I" inside tmux to install plugins
```
7. Ohmyzsh:
```sh
# install from ohmyzsh docs
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```
8. Pnpm:
```sh
# install from pnpm docs
# TODO: update to bun
# TODO: say to install "active lts" node 
# TODO: add uv
pnpm env use --global lts # Fix for NodeJS & npm
```
9. Rbenv:
```sh
# install from rbenv docs & install ruby-build plugin for "install" subcommand
# git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
rbenv install <version>
rbenv global <version>
```
10. Copy configuration files
11. Generate ssh key pair
```sh
# add where necessary after
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C <email>
```
12. Add git aliases:
```sh
git config --global alias.ls "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```
