#!/bin/sh
yay -S betterlockscreen ly
sudo systemctl enable ly.service
sudo systemctl enable betterlockscreen@${USER}
