# dotfiles

## map caps-lock to control on ubuntu

```
sudo vim /etc/default/keyboard
// add
XKBOPTIONS="ctrl:nocaps"

// then also run

setxkbmap -option ctrl:nocaps
```
