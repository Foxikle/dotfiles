# dotfiles
Foxikle's personal dotfiles. These might change a lot. Or a little, who knows!


For my future reference:
To apply these configurations to the `~/.config/` directory, use the 
```bash
stow <option>
```
command. For example, 
```bash
stow hyprland
```
will apply the hyprland setup to the config directory. To add a new configuration to the dotfiles, simply create a directory in this repository with the following naming conventions:

```
mkdir -p <name of application(s)>/.config/<folder where configs are -- omit if n/a>
```
The `.config` folder can be changed if the configs are in a different place. (ie `.local/share` or something).




