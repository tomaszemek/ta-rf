*** Comments ***
This file contains keywords that work with Geocoding API subset of the whole OpenWeather API.
    or that are related to that functionality


*** Settings ***
Library    RequestsLibrary

Resource    resources/constants/APIURL.resource
Resource    resources/constants/HTTPStatus.resource

Resource    resources/APIKey.resource


*** Variables ***


*** Keywords ***
Get Coordinates For Location Name
    [Arguments]    ${city_name}=""    ${state_code}=""    ${country_code}="NL"

    ${geocoding_data_list}=    Get Geocoding Data For Location Name    city_name=${city_name}
    ${geocoding_data_item}=    Get Single Coordinates Pair From List    ${geocoding_data_list}
    Should Be Equal As Strings    first=${geocoding_data_item}[name]    second=${city_name}

    RETURN    ${geocoding_data_item}


Get Geocoding Data For Location Name
    [Arguments]    ${city_name}=""    ${state_code}=""    ${country_code}="NL"

    ${API_KEY}=    Get Random API Key
    ${GEO_DIRECT_LOCATION_URL_API_VAR}    Set Variable     ?q=${city_name},${state_code},${country_code}&appid=${API_KEY}
    ${response}=    GET    ${GEO_DIRECT_LOCATION_URL_API_BASE}${GEO_DIRECT_LOCATION_URL_API_VAR}    expected_status=${HTTP_STATUS_OK}

    RETURN    ${response.json()}


Get Single Coordinates Pair From List
    [Arguments]    ${geocoding_data_list}

    ${geocoding_data_list_length}    Get Length    ${geocoding_data_list}
    Should Be Equal As Integers    ${geocoding_data_list_length}    1

    RETURN    ${geocoding_data_list}[0]
