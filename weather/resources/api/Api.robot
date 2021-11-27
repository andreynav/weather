*** Settings ***
Resource    ../../../import.resource

*** Keywords ***
Get Value For Specific JPath
    [Documentation]    Get value of specific parameter for a city
    [Arguments]    ${json_path}
    ...            ${params}
    ${response}    RequestsLibrary.GET    ${API_URL}
    ...                                   ${params}
    RequestsLibrary.Status Should Be    ${CODE_SUCCESS}
    ${temperature}    JSONLibrary.Get Value From Json    ${response.json()}
    ...                                                  ${json_path}
    [Return]    ${temperature[0]}
