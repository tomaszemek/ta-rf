*** Variables ***
${WEATHER_URL_API_BASE}    https://api.openweathermap.org/data/2.5/weather
${WEATHER_URL_API_VAR_TEMPLATE}    ?lat={lat}&lon={lon}&appid={api_key}

${WEATHER_URL_WWW}    https://openweathermap.org/current

${GEO_DIRECT_LOCATION_URL_API_BASE}    http://api.openweathermap.org/geo/1.0/direct
${GEO_DIRECT_LOCATION_URL_API_VAR_TEMPLATE}    ?q={city name},{state code},{country code}&limit={limit}&appid={API key}
