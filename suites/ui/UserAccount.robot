*** Comments ***
This is an example of parametrized tests using Robot Framework
The data driver library is used to turn single test case template into set 
...    of specific test case executions using the provided CSV file 
...    specifying the parameter combinations

*** Settings ***
Library    DataDriver
Test Template    Login With Email And Password

Resource    resources/ui/Login.resource

Library    Browser
Suite Setup    New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Setup    New Context
Test Teardown    Close Context
Suite Teardown    Close Browser


*** Variables ***
${BROWSER}    %{BROWSER}
${HEADLESS}    False


*** Test Cases ***
Registered Users Can Login    Default    UserData


*** Keywords ***
Login With Email And Password
    [Arguments]    ${USER_FIRST_NAME}    ${USER_LAST_NAME}    ${USER_EMAIL}    ${USER_PASSWORD}    ${USER_ROLE}

    User Shall Be Able To Log In    ${USER_FIRST_NAME}    ${USER_LAST_NAME}    ${USER_EMAIL}    ${USER_PASSWORD}    ${USER_ROLE}

    RETURN



