*** Comments ***
This test suite contains tests based on current location
The requests library is used to send request and return response
Various third party sites are used for intermediate resolve steps

*** Settings ***
Library    RequestsLibrary

Resource    resources/weather/api/constants/GeolocateURL.resource
Resource    resources/weather/api/constants/HTTPStatus.resource

Resource    resources/weather/api/Geolocate.resource
Resource    resources/weather/api/Weather.resource

Suite Teardown  Delete All Sessions


*** Variables ***


*** Test Cases ***
Weather For Current Location Shall Be Received
    
    ${current_ip_address}=    Determine Current IP Address

    ${location_info}=    Determine Current Location From IP Address    ${current_ip_address}

    ${forecast}=    Get Weather Forecast For Coordinates    ${location_info}

    ${forecast_information}=    Extract Weather Information From Forecast    ${forecast}

    Log To Console    ${forecast_information}






