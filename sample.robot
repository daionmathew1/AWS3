*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
Library     String
*** Variables ***
${base_url}    https://reqres.in

*** Test Cases ***
ListUser
    [Tags]  Demo
    Create Session    session1    ${base_url}   disable_warnings=1
    ${endpoint}     Set Variable    /api/users?page=2
    ${response}     GET On Session  session1    ${endpoint}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}  200
SingleUser
    ${endpoint2}     Set Variable    /api/users/2
    ${response}     GET On Session  session1    ${endpoint2}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}  200
ListResource
    ${endpoint3}     Set Variable    /api/unknown
    ${response}     GET On Session  session1    ${endpoint3}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}  200
SingleResource
    ${endpoint4}     Set Variable    /api/unknown/2
    ${response}     GET On Session  session1    ${endpoint4}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}  200
put_update
    ${edit}=        Create Dictionary   "id": 7     "first_name": "Michael"
    ${response}=      PUT On Session   session1     /api/users/2    data=${edit}
    Log To Console    ${response.content}
    ${status-code1}=  Convert To String   ${response.status_code}
    Should Be Equal    ${status-code1}   200
patch_update
    ${edit}=        Create Dictionary    "city"="Mumbai"
    ${response}=      PATCH On Session   session1     /api/users/2    data=${edit}
    Log To Console    ${response.content}
    ${status-code1}=  Convert To String   ${response.status_code}
    Should Be Equal    ${status-code1}   200
Register
    ${endpoint4}     Set Variable    /api/register
    ${response}     GET On Session  session1    ${endpoint4}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    ${status-code1}=  Convert To String   ${response.status_code}
    Should Be Equal    ${status-code1}   200
Login
    ${endpoint4}     Set Variable    /api/login
    ${response}     GET On Session  session1    ${endpoint4}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    ${status-code1}=  Convert To String   ${response.status_code}
    Should Be Equal    ${status-code1}   200
Delete
    ${response}=   DELETE On Session   session1     api/user/2
    Log To Console    ${response.content}
DelayResponse
    ${endpoint4}     Set Variable    /api/users?delay=3
    ${response}     GET On Session  session1    ${endpoint4}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    ${status-code1}=  Convert To String   ${response.status_code}
    Should Be Equal    ${status-code1}   200