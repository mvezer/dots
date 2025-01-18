# arch-setup

Notes for private arch post-install setup

First run setup:
```
sudo ./setup
```

Edit the name and email in the post-setup script, then run it:
```
./post-setup
```

## Post install

- set us keyboard as default
    - edit /etc/default/keyboard
    - edit /etc/X11/xorg.conf.d/00-keyboard.conf
- sddm theme
    - edit the `Current` entry in /etc/sddm.conf.d/sddm.conf

