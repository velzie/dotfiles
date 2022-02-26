#!/bin/bash
img=$(find ~/Documents/DE/NEW/tinywalls -type f | shuf -n 1)

feh --bg-scale $img
