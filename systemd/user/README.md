To use any of these systemd services, check the associated files and make sure
you install the required scripts to the specified directories. I tend to copy
this folder to ~/.config/systemd to install my user units, but do whatever
works for you. (symlinking the directory did NOT work for me!)

E.g. You need to copy gdrive_crypt.sh to ~/bin (%h/bin) in order for the rclone
mount service to work.

From there you can just do reload the systemctl user daemon and do something
like systemctl start --user \[\[service]]. journalctl --user -u \[\[unit_name]]
is useful for monitoring the associated logs!

