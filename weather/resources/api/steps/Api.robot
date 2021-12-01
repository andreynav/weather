*** Settings ***
Resource    ../../../../import.resource

*** Keywords ***
Get Temperature From Weather Api
    [Documentation]    Get value of specific parameter for a city
    [Arguments]    ${json_path}
    ...            ${params}
    ${response}    weather.Get Weather Data From Api    ${params}
    ${temperature}    JSONLibrary.Get Value From Json    ${response.json()}
    ...                                                  ${json_path}
    [Return]    ${temperature[0]}
