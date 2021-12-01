*** Settings ***
Resource    ../../../../import.resource

*** Keywords ***
Get Weather Data From Api
    [Documentation]    Get weather data via API for specific arguments and return it
    [Arguments]    ${params}
    ${response}    RequestsLibrary.GET    ${API_ENDPOINT_WEATHER}
    ...                                   ${params}
    RequestsLibrary.Status Should Be    ${CODE_SUCCESS}
    [Return]    ${response}
