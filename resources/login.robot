*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}        http://the-internet.herokuapp.com/login

#Selector
${USERNAME_FIELD}   id=username
${PASSWORD_FIELD}   id=password
${LOGIN_BUTTON}     css=button.radius
${FLASH_MESSAGE}    id=flash
${LOGOUT_BUTTON}    //a[@href='/logout']

*** Keywords ***
Open Login Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --guest  #แก้บัค Popup save password ใน Chrome ชอบแจ้งขึ้่นมาทำให้ DOM ผิด
    Create WebDriver    Chrome    options=${options}
    Go To    ${LOGIN_URL}
    Maximize Browser Window

Input Credentials And Submit
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}
    Wait Until Page Contains    Login Page    5s
    Click Button  ${LOGIN_BUTTON}

Flash Message Should Contain
    [Arguments]    ${expected}
    Wait Until Element Contains    ${FLASH_MESSAGE}    ${expected}    timeout=5s
    ${flash}=    Get Text    ${FLASH_MESSAGE}
    Log    Flash Message is: ${flash}
    Should Contain    ${flash}    ${expected}

Logout
    Click Element    ${LOGOUT_BUTTON}
