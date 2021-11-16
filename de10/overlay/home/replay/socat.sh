#!/bin/sh
socat pty,raw,echo=0,link=/tmp/replay-usart STDIN,raw,echo=0

