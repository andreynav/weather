*** Settings ***
Resource    ../../../../import.resource

*** Keywords ***
Get Random Measure Except
    [Documentation]    Get random temperature measure except getting as parameter
    [Arguments]    ${existing_measure}
    ${unit_keys}    Collections.Get Dictionary Keys    ${UNITS}
    ${random_meausure}    RandomList.Get Random Item From List    ${unit_keys}
    ...                                                            ${existing_measure}
    [Return]    ${random_meausure}

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

