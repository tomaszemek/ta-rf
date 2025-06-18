*** Comments ***
This is an example of parametrized tests using Robot Framework
The data driver library is used to turn single test case template into set 
...    of specific test case executions using the provided CSV file 
...    specifying the parameter combinations

*** Settings ***
Library    DataDriver
Test Template    Compare Weather Forecast ID with City Name ID

Resource    resources/weather/api/constants/WeatherURL.resource
Resource    resources/weather/api/constants/HTTPStatus.resource

Resource    resources/weather/api/Geocoding.resource
Resource    resources/weather/api/Weather.resource


*** Variables ***


*** Test Cases ***
Received City ID Shall Match Requested City Name    Default    UserData


*** Keywords ***
Compare Weather Forecast ID with City Name ID
    [Arguments]    ${CITY_NAME}    ${CITY_ID}

    ${forecast}=    Get Weather Forecast For City Name    ${CITY_NAME}

    Should Be Equal As Integers    first=${forecast}[id]    second=${CITY_ID}

    RETURN



