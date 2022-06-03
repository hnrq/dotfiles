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

if hash systemctl 2>/dev/null ; then
  services=""
  systemctl="systemctl --user"

  for service in $services ; do
    echo -n "$service... "
    if ! $systemctl is-enabled $service ; then $systemctl enable $service ; fi
    echo -n "$service... "
    if ! $systemctl is-active $service ; then $systemctl start $service ; fi
  done

  services_system="ly betterlockscreen"
  systemctl="sudo systemctl"
  for service in $services_system ; do
    echo -n "$service..."
    if ! $systemctl is-enabled $service ; then $systemctl enable $service ; fi
  done
fi


