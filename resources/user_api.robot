*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://reqres.in/api
${API_KEY}     reqres-free-v1  #เว็บไซต์เดิมอาจไม่ต้องใช้ API KEY แต่ปัจจุบันจำเป็นต้องใช้ API Key (ทดสอบผ่านการทำ curl แล้ว ไม่งั้น json ไม่ออก)

*** Keywords ***
Get User Profile
    [Arguments]    ${user_id}
    &{headers}=    Create Dictionary    x-api-key=${API_KEY}
    Log    ${BASE_URL}
    Create Session    reqres    ${BASE_URL}    headers=${headers}    verify=true
    ${response}=    Get On Session    reqres    /users/${user_id}    expected_status=any
    RETURN    ${response}