#!/bin/sh
message="Do you wish to install this program?"
default_yn="y"

while [ "$1" != "" ]; do
  case "$1" in
    -d | --default )       default_yn="$2";     shift;;
    -m | --message )  message="$2"; shift;;
  esac
  shift
done

read -p "${message} $([[ $default_yn == [Nn]* ]] && echo "(y/N)" || echo "(Y/n)")" yn

if [[ -z "$yn" ]]; then
  yn=$default_yn
fi

[[ $yn == [Nn]* ]] && echo no || echo yes

