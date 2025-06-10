*** Comments ***
This test suite performs API and acceptance testing on OpenWeatherAPI web service
The requests library is used to send request and return response

*** Settings ***
Library    RequestsLibrary

Resource    resources/constants/APIURL.resource
Resource    resources/constants/HTTPStatus.resource

Resource    resources/APIKey.resource
Resource    resources/Geocoding.resource
Resource    resources/Weather.resource

Suite Teardown  Delete All Sessions


*** Variables ***


*** Test Cases ***
Website is accessible
    ${response}=    GET    ${WEATHER_URL_WWW}    expected_status=${HTTP_STATUS_OK}


API is not accessible with no parameters
    ${response}=    GET    ${WEATHER_URL_API_BASE}    expected_status=${HTTP_STATUS_UNAUTHORIZED}


API is not accessible with empty parameters
    ${WEATHER_URL_API_VAR}    Set Variable     ?lat=0&lon=0&appid=""
    ${response}=    GET    ${WEATHER_URL_API_BASE}${WEATHER_URL_API_VAR}    expected_status=${HTTP_STATUS_UNAUTHORIZED}


API is accessible with random valid API_KEY
    ${API_KEY}=    Get Random API Key
    ${WEATHER_URL_API_VAR}    Set Variable     ?lat=0&lon=0&appid=${API_KEY}
    ${response}=    GET    ${WEATHER_URL_API_BASE}${WEATHER_URL_API_VAR}    expected_status=${HTTP_STATUS_OK}


Weather forecast for city name gives information
    ${CITY_NAME}    Set Variable    Utrecht
    
    ${forecast}=    Get weather forecast for city name    ${CITY_NAME}
    ${forecast_information}=    Extract weather information from forecast    ${forecast}

    Log To Console    ${forecast_information}


