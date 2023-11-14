gentoo-pipewire-launcher &
setxkbmap -layout se &
numlockx &

if [[ -z "${DBUS_SESSION_BUS_ADDRESS}";
then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi

export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
nm-applet&

exec xmonad
