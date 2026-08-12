# dotfiles

Foxikle's personal dotfiles. These might change a lot. Or a little, who knows!

For my future reference:
To apply these configurations, use the `bin/install.sh` script. 
You can pass the `--skip-deps` flag to bypass installing packages

You can run the install script as you update the files. Use the `bin/update.sh` script to only update the loaded configurations.


To add a new configuration to the dotfiles, simply create a directory in this repository with the following naming conventions:

```
mkdir -p <name of application(s)>/.config/<folder where configs are -- omit if n/a>
```

The `.config` folder can be changed if the configs are in a different place. (ie `.local/share` or something).

> [!NOTE]
> In order for waybar's update and volume controls to work, you must run the following command:
>
> ```sh
>  chmod +x -R configs/waybar/.config/waybar/scripts/
> ```

> [!NOTE]
> In order to setup SDDM (Login screen), you must run the following command:
> The chmods are so the sddm user can access the symlinks
>
> ```sh
> sudo stow -t / sddm
> sudo chmod o+x /home/$USER
> sudo chmod o+x /home/$USER/dotfiles
> sudo chmod o+x /home/$USER/dotfiles/configs/sddm
> ```
