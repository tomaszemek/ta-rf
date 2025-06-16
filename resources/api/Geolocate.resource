*** Settings ***
Library    RequestsLibrary

Resource    resources/api/constants/GeolocateURL.resource
Resource    resources/api/constants/HTTPStatus.resource

Resource    resources/api/GeolocateAPIKey.resource

*** Variables ***


*** Keywords ***
Determine Current IP Address

    ${response}=    GET    ${IP_ADDR_LOCATE_URL_API_BASE}${IP_ADDR_LOCATE_URL_API_VAR_TEMPLATE}    expected_status=${HTTP_STATUS_OK}

    RETURN    ${response.json()}[ip]


Determine Current Location From IP Address
    [Arguments]    ${ip_address}

    ${X-API-Key}=    Get Geolocate API Key

    ${request_headers}=    Create Dictionary    X-API-Key=${X-API-Key}

    ${response}=    GET    ${GEOLOCATE_URL_API_BASE}/query/json/${ip_address}    headers=${request_headers}    expected_status=${HTTP_STATUS_OK}

    RETURN    ${response.json()}
