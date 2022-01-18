#!/bin/sh

# Fetches best mirror
sudo pacman -S reflector && reflector --latest 200 --protocol \
	http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Packages required for dotfiles
sudo pacman -S --needed --no-confirm python-pywal xorg go neovim \
  bspwm sxhkd polybar picom htop rxvt-unicode feh ranger rofi \
  networkmanager network-manager-applet git fish telegram-desktop \
  devmon zsh

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting

# Install yay
git clone --quiet https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
rm -rf yay

# Install AUR packages
yay -S --noconfirm visual-studio-code-bin google-chrome cozette-ttf
