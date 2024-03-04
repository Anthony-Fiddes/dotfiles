# Install sleep script
sudo cp ./sleep_script.sh /usr/lib/systemd/system-sleep/

# Don't turn on bluetooth by default, saves battery
sudo sed -i "s/#\?AutoEnable=true/AutoEnable=false/1" /etc/bluetooth/main.conf

# Useful guide: https://linrunner.de/tlp/faq/ppd.html
yay -R power-profiles-daemon
yay -S tlp fprintd
sudo sed -i "s/#\?PLATFORM_PROFILE_ON_AC=.*/PLATFORM_PROFILE_ON_AC=performance/1" /etc/tlp.conf
sudo sed -i "s/#\?PLATFORM_PROFILE_ON_BAT=.*/PLATFORM_PROFILE_ON_BAT=low-power/1" /etc/tlp.conf
systemctl enable tlp.service
systemctl mask systemd-rfkill.service systemd-rfkill.socket
echo "Run sudo tlp start or restart"
