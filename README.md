# dotfiles

## stow usage

```
# link kitty configs to home
stow kitty -t ~
```

# map caps-lock to control on ubuntu

```
sudo vim /etc/default/keyboard
// add
XKBOPTIONS="ctrl:nocaps"

// then also run

setxkbmap -option ctrl:nocaps
```

## remap on arch
https://wiki.archlinux.org/index.php/xmodmap#Turn_CapsLock_into_Control
