# ~/.xinitrc
# This file is sourced when running startx and 
#    other programs which call xinit
# As in all Bash/sh scripts lines starting with 
#    '#' are comments

STARTUP=x-window-manager

# Define Xresources
userresources=~/.Xresources

# Merge what is available
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# screen layout
#xrandr --output HDMI1 --mode 1920x1200 --pos 1920x0 --rotate normal --output DP1 --off --output VGA1 --mode 1920x1200 --pos 0x0 --rotate normal

# Set background to your favorite pic
nitrogen --restore

#synapse &

dropbox start

volti &

# le trayer
trayer --edge top --align center --SetDockType true --SetPartialStrut false --expand true --widthtype request --tint 0x000000 --heighttype pixel --height 16 --transparent true --alpha 0 &

# applet réseaux
sudo nm-applet &

# set the cursor
xsetroot -cursor_name left_ptr

# xmonad and Java gui
export _JAVA_AWT_WM_NONREPARENTING=1

# file manager daemon
thunar --daemon &

# finally, start WM
exec xmonad
