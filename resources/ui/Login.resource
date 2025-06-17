*** Comments ***
This module contains keywords related to the Login screen and login flow
It uses the Browser library and assumes Browser instance has been already created

*** Settings ***
Library    Browser

Resource    resources/ui/constants/SUTURL.resource

*** Variables ***
# Describe user account types
${USER_ROLE_ADMIN}    admin
${USER_ROLE_USER}    user
${USER_ROLE_UNKNOWN}    unknown


*** Keywords ***
User Shall Be Able To Log In
    [Arguments]    ${user_first_name}    ${user_last_name}    ${user_email}    ${user_password}    ${user_role}=user

    # Log arguments:
    Log To Console    ${user_email}    ${user_role}
   
    # Open New Browser Page
    New Page

    # Navigate to Login Page
    Open Login Page

    # Login with user
    Enter Credentials and Login    ${user_email}    ${user_password}

    # User shall be logged in
    User Shall Be Logged In    ${user_first_name}    ${user_last_name}    ${user_role}

    # Close page and return
    Close Page

    RETURN

Open Login Page

    # Open Login Page:
    Go To    ${SUT_URL_LOGIN}

    # Verify that it is opened
    Get Title    contains    Login

    RETURN

Enter Credentials And Login
    [Arguments]    ${user_email}    ${user_password}

    Fill Text    id=email    ${user_email}
    Fill Text    id=password    ${user_password}

    Click    css=.btnSubmit

    RETURN

User Shall Be Logged In
    [Arguments]    ${user_first_name}    ${user_last_name}    ${user_role}

    IF    "${user_role}" == "${USER_ROLE_ADMIN}"

        Verify Admin Account Page Is Opened

    ELSE IF    "${user_role}" == "${USER_ROLE_USER}"

        Verify User Account Page Is Opened    ${user_first_name}    ${user_last_name}

    ELSE IF    "${user_role}" == "${USER_ROLE_UNKNOWN}"

        Verify User Login Failed

    ELSE 

        Fail

    END

    RETURN


Verify Admin Account Page Is Opened

    Get Text    h1    equals    Sales over the years

    RETURN

Verify User Account Page Is Opened
    [Arguments]    ${user_first_name}    ${user_last_name}

    Get Text    h1    equals    My account

    ${expected_full_name}=    Set Variable    ${user_first_name} ${user_last_name}
    ${actual_full_name}=    Get Text    id=menu
        
    Should Be Equal As Strings    ${actual_full_name.strip()}    ${expected_full_name}

    RETURN

Verify User Login Failed
    
    Get Text    css=.help-block    equals    Invalid email or password

    RETURN