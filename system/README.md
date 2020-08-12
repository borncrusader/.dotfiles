## Linux
1. How to use Arch Linux on HiDPI displays

From [the wiki](https://wiki.archlinux.org/index.php/HiDPI), there are multiple
ways to set this. Since I use i3, it's as simple as setting the `Xft.dpi` in
`~/.Xresources`. No other environment variable, GDK specific or `xrandr`
settings are configured.

I don't need to scale down GRUB and I don't use many KDE apps too. Most apps
honor the X settings including electron based applications.
