#!/bin/bash

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Welcome to my install script!"

# Install yay
sudo pacman -S --needed yay
echo "Installed yay"

echo "Installing required packages"
yay -S --needed - <"$DOTFILES/packages.txt"
echo "Done installing packages!"

echo "Applying config files!"
for CONFIG in "$DOTFILES/configs"/*; do
  [ -d "$CONFIG" ] || continue
  CONFIG_NAME="$(basename "$CONFIG")"

  # SDDM is handled separtely
  [ "$CONFIG_NAME" = "sddm"] && continue

  stow --dir="$DOTFILES/configs" --target="$HOME" "$CONFIG_NAME"
done

echo "Applying bash configs"
stow --dotfiles --target="$HOME" bash

echo "Applying sddm configs"
sudo stow --dir="$DOTFILES/configs" --target="/" sddm
sudo chmod o+x /home/$USER
sudo chmod o+x /home/$USER/dotfiles
sudo chmod o+x /home/$USER/dotfiles/configs
sudo chmod o+x /home/$USER/dotfiles/configs/sddm

echo "Patching waybar scripts"
chmod +x "$DOTFILES/configs/waybar/.config/waybar/scripts/*"

echo "Done!"
