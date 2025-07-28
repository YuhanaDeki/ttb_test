*** Settings ***
Resource    ../resources/login.robot

Suite Setup    Open Login Page
Suite Teardown    Close Browser

*** Test Cases ***
Login Success
    Input Credentials And Submit    tomsmith    SuperSecretPassword!
    Flash Message Should Contain    You logged into a secure area!
    Logout
    Flash Message Should Contain    You logged out of the secure area!

Login Failed - Password Incorrect
    Input Credentials And Submit    tomsmith    Password! 
    Flash Message Should Contain    Your password is invalid!

Login Failed - Username Not Found
    Input Credentials And Submit    tomholland    Password!
    Flash Message Should Contain   Your username is invalid! 
