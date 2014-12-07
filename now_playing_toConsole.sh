#! /bin/sh
cat < /etc/now_playing | awk -F"=" '!/artwork=/ && !/genre=/ && !/comment=/{print $2 | "tclsh /etc/smartie/smartie-tail.tcl -tty /dev/ttyUSB0"}' &