# 08/27/2019 - this is not used for ska-arch

# map capslock to control
#xmodmap ~/.xmodmap
#
## xkb maps
#setxkbmap -option ctrl:nocaps -option terminate:ctrl_alt_bksp

# run display manager
dbus-launch --exit-with-session
exec i3
