#!/usr/bin/env bash

main(){
	CURRENT_V_=$(</sys/class/power_supply/axp20x-battery/voltage_now)
	CURRENT_T=$(</sys/class/thermal/thermal_zone0/hwmon2/temp1_input)
	#CURRENT_Br=$(< /sys/class/device/backlight/backlight@0/actual_brightness)
	CURRENT_Btt=$(< /sys/class/power_supply/axp20x-battery/capacity)
	CURRENT_BttC=$(< /sys/class/power_supply/axp20x-battery/status)

	divid=1000000
	divida=1000
	v_sign="V"
	c_sign="C"
	perc_="%"
	temp_c=$(echo "scale=0; $CURRENT_T/$divida" | bc -l)
	volts_=$(echo "scale=3; $CURRENT_V_/$divid" | bc -l)
	#+($CURRENT_V_%$divid)))

	echo "${CURRENT_Btt}% ${CURRENT_BttC} ${volts_}${v_sign} | ${temp_c}${c_sign}"
}
main
