*** Comments ***
This is an example of parametrized tests using Robot Framework
The data driver library is used to turn single test case template into set 
...    of specific test case executions using the provided CSV file 
...    specifying the parameter combinations

*** Settings ***
Library    DataDriver
Test Template    Compare Weather Forecast ID with City Name ID

Resource    resources/constants/WeatherURL.resource
Resource    resources/constants/HTTPStatus.resource

Resource    resources/Geocoding.resource
Resource    resources/Weather.resource


*** Variables ***


*** Test Cases ***
Weather Forecast City ID Matches Requested City Name    Default    UserData


*** Keywords ***
Compare Weather Forecast ID with City Name ID
    [Arguments]    ${CITY_NAME}    ${CITY_ID}

    ${forecast}=    Get Weather Forecast For City Name    ${CITY_NAME}

    Should Be Equal As Integers    first=${forecast}[id]    second=${CITY_ID}

    RETURN



