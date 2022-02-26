if [ $(cat ~/.config/polybar/scripts/autoscroll)  == "y" ];
then
	polybar-msg hook autoscroll 1
	echo "n" > ~/.config/polybar/scripts/autoscroll
	xinput set-prop 11 "libinput Scroll Method Enabled" 0, 0, 0;
	xinput set-prop 11 "libinput Button Scrolling Button" 2

else
	polybar-msg hook autoscroll 2
	echo "y" > ~/.config/polybar/scripts/autoscroll
	xinput set-prop 11 "libinput Scroll Method Enabled" 0, 0, 1;
	xinput set-prop 11 "libinput Button Scrolling Button" 2

fi
