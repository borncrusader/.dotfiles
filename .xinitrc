#exec ck-launch-session startxfce4
#exec ck-launch-session gnome-session-cinnamon
#exec ck-launch-session gnome-session
#exec ck-launch-session openbox-session
#exec ck-launch-session startkde
#exec openbox-session

artha &
parcellite &
pnmixer &
nm-applet &
dropboxd &
batti &

~/bin/dual_setup.sh auto

# map capslock to control
xmodmap ~/.xmodmap

exec awesome
