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

# Locators
${LOCATOR_LINK_SIGN_IN}    [data-test="nav-sign-in"]
${LOCATOR_INPUT_EMAIL}    id=email
${LOCATOR_INPUT_PASSWORD}    id=password
${LOCATOR_BUTTON_LOGIN}    css=.btnSubmit
${LOCATOR_TEXT_LOGIN_FAILED}    css=.help-block
${LOCATOR_TITLE_ACCOUNT_PAGE}    h1
${LOCATOR_LINK_FULL_NAME}    id=menu

# Labels and texts and titles
${TITLE_LOGIN}    Login
${TITLE_ADMIN_ACCOUNT_PAGE}    Sales over the years
${TITLE_USER_ACCOUNT_PAGE}    My account
${TEXT_LOGIN_FAILED}    Invalid email or password


*** Keywords ***
User Shall Be Able To Log In
    [Arguments]    ${user_first_name}    ${user_last_name}    ${user_email}    ${user_password}    ${user_role}=user

    # Log arguments:
    Log To Console    ${user_email}    ${user_role}
   
    # Open New Browser Page
    New Page

    # Start at Home
    Go To    ${SUT_URL_HOME}

    # User shall not be logged in
    User Full Name Shall Not Be Visible

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

    Click    ${LOCATOR_LINK_SIGN_IN}
    
    # Verify that it is opened
    Get Title    contains    ${TITLE_LOGIN}

    Wait For Elements State    ${LOCATOR_BUTTON_LOGIN}    visible

    RETURN

Enter Credentials And Login
    [Arguments]    ${user_email}    ${user_password}

    Fill Text    ${LOCATOR_INPUT_EMAIL}    ${user_email}
    Fill Text    ${LOCATOR_INPUT_PASSWORD}    ${user_password}

    Click    ${LOCATOR_BUTTON_LOGIN}

    RETURN

User Shall Be Logged In
    [Arguments]    ${user_first_name}    ${user_last_name}    ${user_role}

    # For each user role the expected outcome is different
    IF    "${user_role}" == "${USER_ROLE_ADMIN}"

        Account Page Shall Be Opened    ${TITLE_ADMIN_ACCOUNT_PAGE}

        User Full Name Shall Be Visible    ${user_first_name}    ${user_last_name}
        
    ELSE IF    "${user_role}" == "${USER_ROLE_USER}"

        Account Page Shall Be Opened    ${TITLE_USER_ACCOUNT_PAGE}

        User Full Name Shall Be Visible    ${user_first_name}    ${user_last_name}

    ELSE IF    "${user_role}" == "${USER_ROLE_UNKNOWN}"

        User Login Shall Have Failed

        User Full Name Shall Not Be Visible

    ELSE 

        Fail

    END

    RETURN

Account Page Shall Be Opened
    [Arguments]    ${expected_title}

    Get Text    ${LOCATOR_TITLE_ACCOUNT_PAGE}    equals    ${expected_title}

    RETURN

User Login Shall Have Failed
    
    Get Text    ${LOCATOR_TEXT_LOGIN_FAILED}    equals    ${TEXT_LOGIN_FAILED}

    RETURN

User Full Name Shall Be Visible
    [Arguments]    ${user_first_name}    ${user_last_name}

    ${expected_full_name}=    Set Variable    ${user_first_name} ${user_last_name}
    ${actual_full_name}=    Get Text    ${LOCATOR_LINK_FULL_NAME}
        
    Should Be Equal As Strings    ${actual_full_name.strip()}    ${expected_full_name}

User Full Name Shall Not Be Visible

    Wait For Elements State    ${LOCATOR_LINK_SIGN_IN}    visible

    RETURN


