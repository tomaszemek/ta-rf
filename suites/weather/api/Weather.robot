*** Comments ***
This test suite performs API and acceptance testing on OpenWeatherAPI web service
The requests library is used to send request and return response

*** Settings ***
Library    RequestsLibrary

Resource    resources/weather/api/constants/WeatherURL.resource
Resource    resources/weather/api/constants/HTTPStatus.resource

Resource    resources/weather/api/WeatherAPIKey.resource
Resource    resources/weather/api/Geocoding.resource
Resource    resources/weather/api/Weather.resource

Suite Teardown  Delete All Sessions


*** Variables ***


*** Test Cases ***
Website Shall Be Accessible
    ${response}=    GET    ${WEATHER_URL_WWW}    expected_status=${HTTP_STATUS_OK}


API Shall Not Be Accessible With No Parameters Provided
    ${response}=    GET    ${WEATHER_URL_API_BASE}    expected_status=${HTTP_STATUS_UNAUTHORIZED}


API Shall Not Be Accessible With Empty Parameters Provided
    ${WEATHER_URL_API_VAR}    Set Variable     ?lat=0&lon=0&appid=""
    ${response}=    GET    ${WEATHER_URL_API_BASE}${WEATHER_URL_API_VAR}    expected_status=${HTTP_STATUS_UNAUTHORIZED}


API Shall Be Accessible With Valid API_KEY
    ${API_KEY}=    Get Weather API Key
    ${WEATHER_URL_API_VAR}    Set Variable     ?lat=0&lon=0&appid=${API_KEY}
    ${response}=    GET    ${WEATHER_URL_API_BASE}${WEATHER_URL_API_VAR}    expected_status=${HTTP_STATUS_OK}

Weather Forecast Request For A City Name Shall Receive Information
    ${CITY_NAME}    Set Variable    Utrecht
    
    ${forecast}=    Get Weather Forecast For City Name    ${CITY_NAME}
    ${forecast_information}=    Extract Weather Information From Forecast    ${forecast}

    Log To Console    ${forecast_information}


