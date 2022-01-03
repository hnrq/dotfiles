#!/bin/sh

# Fetches best mirror
sudo pacman -S reflector && reflector --latest 200 --protocol \
	http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Packages required for dotfiles
sudo pacman -S --needed --no-confirm python-pywal xorg go fish neovim \
  bspwm sxhkd polybar picom htop rxvt-unicode feh ranger rofi \
  networkmanager network-manager-applet git fish telegram-desktop 

# Install yay
git clone --quiet https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
rm -rf yay

# Install AUR packages
yay -S --noconfirm fisher visual-studio-code-bin google-chrome 
