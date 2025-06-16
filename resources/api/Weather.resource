*** Comments ***
This file holds keywords: blocks of code that performs specialized operations
As each of these keywords can be reused by multiple tests, they are put here 
...    into dedicated file and marked as resource.

*** Settings ***
Library    RequestsLibrary

Resource    resources/api/constants/WeatherURL.resource
Resource    resources/api/constants/HTTPStatus.resource

Resource    resources/api/WeatherAPIKey.resource
Resource    resources/api/Geocoding.resource

*** Keywords ***
Get Weather Forecast For City Name
    [Arguments]    ${city_name}

    ${coordinates}=    Get Coordinates For Location Name    city_name=${CITY_NAME}

    ${weather_forecast}=    Get Weather Forecast For Coordinates    ${coordinates}

    RETURN    ${weather_forecast}


Get Weather Forecast For Coordinates
    [Arguments]    ${coordinates}

    ${API_KEY}=    Get Weather API Key
    ${WEATHER_URL_API_VAR}    Set Variable     ?lat=${coordinates}[lat]&lon=${coordinates}[lon]&appid=${API_KEY}
    ${response}=    GET    ${WEATHER_URL_API_BASE}${WEATHER_URL_API_VAR}    expected_status=${HTTP_STATUS_OK}

    RETURN    ${response.json()}


Extract Weather Information From Forecast
    [Arguments]    ${weather_forecast_response}

    ${weather_list}=    Set Variable    ${weather_forecast_response}[weather]
    ${weather_list_length}=    Get Length    ${weather_list}
    Should Be Equal As Integers    ${weather_list_length}    1

    ${result_message}=    Catenate    Weather forecast for    ${weather_forecast_response}[name]    is    ${weather_list}[0][main]    ,    ${weather_list}[0][description]

    RETURN    ${result_message}    