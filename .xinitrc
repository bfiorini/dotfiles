# ~/.xinitrc
# This file is sourced when running startx and 
#    other programs which call xinit
# As in all Bash/sh scripts lines starting with 
#    '#' are comments

# Define Xresources
userresources=~/.Xresources

# Merge what is available
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# Le trayer
trayer --edge top --align center --SetDockType true --SetPartialStrut false --expand true --widthtype request --tint 0x000000 --heighttype pixel --height 16 --transparent true --alpha 0 &

# Volume icon in trayer
volti &

# Network-Manager applet
sudo nm-applet &

# Set background to your favorite pic
nitrogen --restore

# Set the cursor
xsetroot -cursor_name left_ptr

# fix xmonad and Java gui
export _JAVA_AWT_WM_NONREPARENTING=1

# File manager daemon
thunar --daemon &

# Dropbox daemon
dropbox start

# Clipboard manager
parcellite &

# Finally start WM
if [ -x /usr/bin/ck-launch-session ]; then
    exec ck-launch-session dbus-launch --exit-with-session xmonad
else
    exec xmonad
fi
