#!/bin/sh
# ~/.xinitrc
# This file is sourced when running startx and 
#    other programs which call xinit

common() {
    userresources=~/.Xresources
    # Merge Xresources
    if [ -f "$userresources" ]; then
        xrdb -merge "$userresources"
    fi
    # File manager daemon
    thunar --daemon &
    # Dropbox daemon
    (sleep 60 && dropbox start)&
    # Volume icon in trayer
    pasystray &
    # Screensaver
    xscreensaver -nosplash &
    # Compose key
    setxkbmap -option compose:ralt
    # Terminal daemon
    urxvtd -q -o -f
    # don't activate screensaver
    xset s off
    # disable DPMS (Energy Star) features.
    xset -dpms
    # don't blank the video device
    xset s noblank
}

startxmonad() {
    # Le trayer
    trayer --edge top --align center --SetDockType true --SetPartialStrut false --expand true --widthtype request --tint 0x000000 --heighttype pixel --height 16 --transparent true --alpha 0 &
    # Network-Manager applet
    sudo nm-applet &
    # Set background to your favorite pic
    nitrogen --restore
    # Set the cursor
    xsetroot -cursor_name left_ptr
    # fix xmonad and Java gui
    export _JAVA_AWT_WM_NONREPARENTING=1
    # Clipboard manager
    #parcellite &
    # Finally start WM
    exec dbus-launch --exit-with-session xmonad
}

startxfce() {
    exec dbus-launch --exit-with-session startxfce4
}

common

case "$1" in
    startxfce4) startxfce;;
    xmonad) startxmonad;;
    *) startxmonad;;
esac
