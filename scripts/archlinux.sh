#!/usr/bin/env sh

set -o errexit -o nounset

ins="pacman -S --noconfirm --needed"
pkgs_aur="yay ly google-chrome visual-studio-code-bin"
pkgs=""

build() {
  PKG_URL="https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz"
  PKG_NAME="${PKG_URL##*/}" # e.g yay.tar.gz
  PKG="${PKG_NAME%%.*}" # e.g yay
  BUILD_DIR="$HOME/build/$PKG"
  [ -d "$BUILD_DIR" ] || mkdir -p "$BUILD_DIR"
  [ -d "$BUILD_DIR" ] && rm -rf "$BUILD_DIR"/*
  ( cd "$BUILD_DIR" \
    && curl -o "$PKG_NAME" -L "$PKG_URL" \
    && tar xvf "$PKG_NAME" \
    && cd "$PKG" \
    && makepkg -si --noconfirm
  )
}

install_deps() {
  pkgs="gnupg pass xclip bspwm sxhkd python-pywal xorg-xinit xorg-server xcape
    base-devel feh picom maim zathura zathura-pdf-mupdf fdm rxvt-unicode sxhkd
    imagemagick rofi ranger youtube-dl unzip ffmpegthumbnailer tmux xss-lock
    zsh zsh-autosuggestions zsh-syntax-highlighting polybar picom alsa-utils
    alsa-plugins alsa-lib"
}

install_pulse() {
  pkgs="$pkgs pulseaudio firefox"
}

install_alsa() {
  pkgs="$pkgs alsa-utils alsa-plugins ladspa swh-plugins libsamplerate"
  pkgs_aur="$pkgs_aur brave-bin"
}

install_emacs() {
  pkgs="$pkgs ripgrep emacs jq"
}

install_nvim() {
  pkgs="$pkgs neovim"
}

install_extra_deps() {
  for pkg in $pkgs_aur ; do
    build "$pkg"
  done
}

usage() {
  printf "\nUsage:\n"
  echo " --deps         Install dependencies"
  echo " --sound-pulse  Install deps for PulseAudio"
  echo " --sound-alsa   Install deps for ALSA"
  echo " --extra-deps   Install other dependencies"
  echo " --nvim          Install deps for neovim"
  echo " --emacs        Install deps for emacs"
}

## CLI options
DEPS=false
PULSE=false
ALSA=false
EXTRA=false
NVIM=false
EMACS=false

if [ "$#" -eq 0 ] ; then usage ; exit 1 ; fi

while [ "$#" -gt 0 ] ; do
  case "$1" in
    --deps) DEPS=true ;;
    --sound-pulse) PULSE=true ;;
    --sound-alsa) ALSA=true ;;
    --extra-deps) EXTRA=true ;;
    --nvim) NVIM=true ;;
    --emacs) EMACS=true ;;
    *) usage; exit 1 ;;
  esac
  shift
done

main() {
  "$DEPS" && install_deps
  "$PULSE" && install_pulse
  "$ALSA" && install_alsa
  "$NVIM" && install_nvim
  "$EMACS" && install_emacs

  sudo $ins $pkgs

  "$EXTRA" && install_extra_deps

  exit 0
}

main "$@"
