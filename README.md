# dotfiles

* Managing Dotfiles for Various Devcies

## Devices

### Lenovo Slim 7i 13ITL5 (`2021`)

* `OS`: Arch Linux
* `Window Manager`: [sway](https://swaywm.org/)
  * `arch_install` will be automatically install when selected.
* `Top (or Status) Bar`: [i3blocks](https://github.com/vivien/i3blocks)
* `Application Launcher`: [wofi](https://man.archlinux.org/man/wofi.1.en)
* `Network Manager`: `systemd-networkd`
  * Used `iwd` (and `iwctl`) when install arch linux.
  
#### Hardware Specific Configuration

* `BIOS`
  * **Turned Off** `Secure Boot`

#### Software Specific Configuration

1. Install `otf-font-awesome` for additonal font.
```bash
$ sudo pacman -S otf-font-awesome terminus-font noto-fonts-cjk ttf-dejavu
```

2. Install `linux-firmware` for Fix Sound issues
```bash
$ sudo pacman -S linux-firmware
$ sudo reboot
```

3. Install `i3blocks` for Status bar.
  * `i3-wm` for sending messages into `i3blocks`
```bash
$ pacman -S i3blocks i3-wm
```

4. Install `xorg`, `xorg-xinit` and `xterm` (?) for launching sway
  * `TODO`: Check this is required.
  ```bash
  $ pacman -S xorg xorg-xinit sterm
  ```

5. Install `wofi` for Launcher
```bash
sudo pacman -S wofi
```

6. Copy Required Configuration & Reboot


#### Misc.

* Turn on Firefox's ffmpeg.vaapi configuration via `about:config` (?)
to use Hardware Acceleration.