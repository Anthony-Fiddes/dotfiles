# Don't turn on bluetooth by default, saves battery
sudo sed -i "s/#*AutoEnable=true/AutoEnable=false/" /etc/bluetooth/main.conf
