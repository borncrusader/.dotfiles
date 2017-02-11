#exec ck-launch-session startxfce4
#exec ck-launch-session gnome-session-cinnamon
#exec ck-launch-session gnome-session
#exec ck-launch-session openbox-session
#exec ck-launch-session startkde
#exec openbox-session
#exec awesome

# startup apps
#artha &
#parcellite &
#pnmixer &
#nm-applet &
#dropbox &
#batti &

#~/bin/dual_setup.sh auto

# map capslock to control
xmodmap ~/.xmodmap

# xkb maps
setxkbmap -option ctrl:nocaps -option terminate:ctrl_alt_bksp

exec i3
