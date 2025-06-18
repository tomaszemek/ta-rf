*** Comments ***
This module makes sure that the available Weather API keys are all used in a random manner

*** Settings ***
Resource    resources/weather/secrets/GeolocateAPIKey.secret.resource

*** Keywords ***
Get Geolocate API Key
    ${API_KEY}=  Evaluate  random.choice(${GEOLOCATE_API_KEY_SET})  random
    RETURN    ${API_KEY}