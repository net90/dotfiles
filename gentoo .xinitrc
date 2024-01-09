gentoo-pipewire-launcher &
setxkbmap -layout se &
numlockx &

exec dbus-launch --sh-syntax --exit-with-session xmonad
