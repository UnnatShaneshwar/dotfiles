#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/source/screenshot_menu/style.rasi"

# Error msg
msg() {
	rofi -theme $HOME/.config/rofi/source/screenshot_menu/message.rasi -e "Please install 'maim' first."
}

# Options
screen=""
area=""
window=""
timed=""

# Variable passed to rofi
options="$screen\n$area\n$window\n$timed"

chosen="$(echo -e "$options" | $rofi_command -p 'App : maim' -dmenu -selected-row 1)"

case $chosen in
    $screen)
		if [[ -f /usr/bin/maim ]]; then
			maim -d 0.6 | tee ~/Pictures/Screenshots/$(date +%s).png | xclip -selection clipboard -t image/png -i
		else
			msg
		fi
        ;;
    $area)
		if [[ -f /usr/bin/maim ]]; then
			maim -s | tee ~/Pictures/Screenshots/$(date +%s).png | xclip -selection clipboard -t image/png -i
		else
			msg
		fi
        ;;
    $window)
		if [[ -f /usr/bin/maim ]]; then
			maim -i $(xdotool getactivewindow) | tee ~/Pictures/Screenshots/$(date +%s).png | xclip -selection clipboard -t image/png -i
		else
			msg
		fi
				;;
    $timed)
		if [[ -f /usr/bin/maim ]]; then
			maim -d 3 | tee ~/Pictures/Screenshots/$(date +%s).png | xclip -selection clipboard -t image/png -i
		else
			msg
		fi
        ;;
esac

