#!/bin/bash

for arg in "$@"; do
  case "$arg" in
  --skip-deps)
    skip_deps=1
    ;;
  esac
done

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Welcome to my install script!"

if [ "$skip_deps" = "1" ]; then
  echo "WARN: Skipping installing packages"
else
  sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
  sudo rm -rf yay-bin/
  echo "Installed yay"

  echo "Installing required packages"
  yay -S --needed - <"$DOTFILES/packages.txt"
  echo "Done installing packages!"
fi

# Use stow to apply configs (separate script to promote reusability)
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd"
"$dir/update.sh"

echo "Done!"
