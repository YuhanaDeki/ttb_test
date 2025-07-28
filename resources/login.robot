*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}        http://the-internet.herokuapp.com/login

#Selector
${USERNAME_FIELD}   id=username
${PASSWORD_FIELD}   id=password
${LOGIN_BUTTON}     css=button.radius
${FLASH_MESSAGE}    id=flash

*** Keywords ***
Open Login Page
    Open Browser    ${LOGIN_URL}    chrome
    Maximize Browser Window

Input Credentials And Submit
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}
    Click Button  ${LOGIN_BUTTON}

Flash Message Should Contain
    [Arguments]    ${expected}
    Wait Until Element Contains    ${FLASH_MESSAGE}    ${expected}    timeout=5s
    ${flash}=    Get Text    ${FLASH_MESSAGE}
    Log    Flash Message is: ${flash}
    Should Contain    ${flash}    ${expected}

Logout
    Click Link    Logout
