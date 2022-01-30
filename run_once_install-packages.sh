#!/bin/sh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --quiet https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
rm -rf yay

# Fetches best mirror
sudo pacman -S --needed --noconfirm reflector && reflector --latest 200 --protocol \
	http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Packages required for dotfiles
sudo pacman -S --needed --noconfirm python-pywal xorg go neovim \
  bspwm sxhkd polybar picom htop rxvt-unicode feh ranger rofi \
  networkmanager network-manager-applet git fish telegram-desktop \
  devmon zsh zsh-autosuggestions zsh-syntax-highlighting


# Install AUR packages
yay -S --noconfirm cozette-ttf
