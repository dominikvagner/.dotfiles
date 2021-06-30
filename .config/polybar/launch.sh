#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
#polybar top -c ~/.config/polybar/config.ini & 

#if [[ $(xrandr -q | grep 'HDMI1 connected') ]] then
#	polybar top_hdmi -c ~/.config/polybar/config.ini &
#fi

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload top -c ~/.config/polybar/config.ini &
  done
else
  polybar --reload top -c ~/.config/polybar/config.ini &
fi
