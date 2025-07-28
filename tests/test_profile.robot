*** Settings ***
Resource    ../resources/user_api.robot

*** Test Cases ***
Get User Profile Success
    ${response}=    Get User Profile    12
    Should Be Equal As Integers    ${response.status_code}    200

    ${json}=    Set Variable    ${response.json()}

    Should Be Equal As Integers   ${json['data']['id']}             12
    Should Be Equal               ${json['data']['email']}          rachel.howell@reqres.in
    Should Be Equal               ${json['data']['first_name']}     Rachel
    Should Be Equal               ${json['data']['last_name']}      Howell
    Should Be Equal               ${json['data']['avatar']}         https://reqres.in/img/faces/12-image.jpg

Get User Profile Not Found
    ${response}=    Get User Profile    1234
    Should Be Equal As Integers    ${response.status_code}    404
    ${text}=    Set Variable    ${response.text}
    Should Be Equal    ${text}    {}
