#!/bin/bash

set -e

sleep 5
DISPLAY=:0 xrandr --newmode "1280x1024_60.00"  108.00  1280 1368 1504 1712  1024 1027 1034 1063 -hsync +vsync
DISPLAY=:0 xrandr --addmode VGA1 1280x1024_60.00
DISPLAY=:0 xrandr --output VGA1 --mode 1280x1024_60.00

echo -e "[+]" "\e[32mXfce installed.\e[0m"