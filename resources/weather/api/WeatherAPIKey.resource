*** Comments ***
This module makes sure that the available Weather API keys are all used in a random manner

*** Settings ***
Resource    resources/weather/api/secrets/WeatherAPIKey.secret.resource

*** Keywords ***
Get Weather API Key
    ${API_KEY}=  Evaluate  random.choice(${WEATHER_API_KEY_SET})  random
    RETURN    ${API_KEY}