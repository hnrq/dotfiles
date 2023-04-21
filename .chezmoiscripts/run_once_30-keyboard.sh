#!/usr/bin/env sh

cyan="\033[0;96m"
white="\033[0;97m"
endc="\033[0m"

msg() {
  echo ""
  echo "$cyan--------------------------------------------------$endc"
  echo "$cyan-->$white $1 $endc"
  echo ""
}

bye() {
  echo ""
    echo "$cyan-->$white End for $0 $endc"
    echo "$cyan--------------------------------------------------$endc"
}

msg "Execute $0..."

sudo locale-gen "pt_BR.UTF-8"
sudo localectl --no-convert set-x11-keymap us_intl
sudo localectl set-locale LANG=pt_BR.UTF-8
