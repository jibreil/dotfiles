#!/bin/sh

if [ "$(bluetoothctl -- show 14:AB:C5:70:C9:97 | grep -i "Powered")" = "	Powered: yes" ]; then
	
	if [ "$(bluetoothctl -- info 20:9B:A5:92:CC:61 | grep -i "Connected")" = "	Connected: yes" ]; then
	
		echo "  "

	else

		echo " "

	fi

else
	echo ""
fi
