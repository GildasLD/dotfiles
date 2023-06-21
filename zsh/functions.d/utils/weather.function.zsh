#!/usr/bin/env zsh

NC="\033[0m"
RED="\033[0;31m"
BOLD="\e[1m"
UNDERLINE="\e[1m"
E_BOLD="\e[22m"
E_UNDERLINE="\e[24m"

getweather() {

	get_icon() {
		case $1 in
		# Icons for weather-icons
		01d) icon="" ;;
		01n) icon="" ;;
		02d) icon="" ;;
		02n) icon="" ;;
		03*) icon="" ;;
		04*) icon="" ;;
		09d) icon="" ;;
		09n) icon="" ;;
		10d) icon="" ;;
		10n) icon="" ;;
		11d) icon="" ;;
		11n) icon="" ;;
		13d) icon="" ;;
		13n) icon="" ;;
		50d) icon="" ;;
		50n) icon="" ;;
		*) icon="" ;;

			# Icons for Font Awesome 5 Pro
			#01d) icon="";;
			#01n) icon="";;
			#02d) icon="";;
			#02n) icon="";;
			#03d) icon="";;
			#03n) icon="";;
			#04*) icon="";;
			#09*) icon="";;
			#10d) icon="";;
			#10n) icon="";;
			#11*) icon="";;
			#13*) icon="";;
			#50*) icon="";;
			#*) icon="";
		esac

		echo $icon
	}
	KEY=$OPEN_WEATHER_API_KEY
	CITY=$OPEN_WEATHER_CITY
	UNITS="metric"
	SYMBOL="°"

	API="https://api.openweathermap.org/data/2.5"

	if [ -n "$CITY" ]; then
		if [ "$CITY" -eq "$CITY" ] 2> /dev/null; then
			CITY_PARAM="id=$CITY"
		else
			CITY_PARAM="q=$CITY"
		fi

		weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS&lang=fr")

	fi

	if [ -n "$weather" ]; then
		weather_desc=$(echo "$weather" | jq -r ".weather[0].description")
		weather_temp=$(echo "$weather" | jq ".main.feels_like")
		weather_min=$(echo "$weather" | jq ".main.temp_min")
		weather_max=$(echo "$weather" | jq ".main.temp_max")
		weather_humidity=$(echo "$weather" | jq ".main.humidity")

		sunrise=$(echo "$weather" | jq ".sys.sunrise")
		sunset=$(echo "$weather" | jq ".sys.sunset")

		weather_pressure=$(echo "$weather" | jq ".main.pressure")
		weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
		weather_all=$(echo "$weather" | jq .)

		echo "$(get_icon "$weather_icon")" "$weather_desc", "${E_BOLD}$weather_temp$SYMBOL${NC}," "(min :" "$weather_min$SYMBOL", max : "$weather_max$SYMBOL)"

		# printf "sunrise : " "$(convert_to_hms "$sunrise")" "sunset : " "$(convert_to_hms "$sunset")"
		# printf "\n\n$weather_all\n"
	fi
}
