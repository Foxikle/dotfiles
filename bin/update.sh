#! /bin/bash

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Applying config files!"
for CONFIG in "$DOTFILES/configs"/*; do
  [ -d "$CONFIG" ] || continue
  CONFIG_NAME="$(basename "$CONFIG")"

  # SDDM is handled separtely
  [ "$CONFIG_NAME" = "sddm" ] && continue
  # Pkg is also handled separtely
  [ "$CONFIG_NAME" = "pkg" ] && continue
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

echo "Applying pkg wrapper"
sudo stow --dir="$DOTFILES/configs" --target="/" pkg

echo "Patching waybar scripts"
chmod +x -R "$DOTFILES/configs/waybar/.config/waybar/scripts/"
