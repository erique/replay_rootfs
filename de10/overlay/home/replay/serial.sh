#!/bin/sh
sudo su -c "stty -F /dev/ttyS1 115200 && cat /dev/ttyS1"
