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

echo "Applying config files!"
for CONFIG in "$DOTFILES/configs"/*; do
  [ -d "$CONFIG" ] || continue
  CONFIG_NAME="$(basename "$CONFIG")"

  # SDDM is handled separtely
  [ "$CONFIG_NAME" = "sddm" ] && continue

  stow --dir="$DOTFILES/configs" --target="$HOME" "$CONFIG_NAME"
done

echo "Applying bash configs"
stow --dotfiles --dir="$DOTFILES" --target="$HOME" bash

echo "Applying sddm configs"
sudo stow --dir="$DOTFILES/configs" --target="/" sddm
sudo chmod o+x /home/$USER
sudo chmod o+x /home/$USER/dotfiles
sudo chmod o+x /home/$USER/dotfiles/configs
sudo chmod o+x /home/$USER/dotfiles/configs/sddm

echo "Patching waybar scripts"
chmod +x -R "$DOTFILES/configs/waybar/.config/waybar/scripts/"

echo "Done!"
