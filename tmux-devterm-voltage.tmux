#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/scripts/shared.sh

devterm_interpolation_string="\#{devterm_temp}"

get_voltage(){
	devterm_voltage=$(echo $("$CURRENT_DIR/scripts/tmux-devterm-voltage.sh"))
	echo $devterm_voltage
}

do_interpolation() {
	local string="$1"
	devterm_voltage=$(echo $(get_voltage))
	local interpolated=${string/${devterm_interpolation_string}/${devterm_voltage}}
	echo "$interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	tmux set-option -gq "$option" "$new_option_value"
	#echo $new_option_value
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
