*** Settings ***
Resource    ../../../../import.resource

*** Keywords ***
Get Onecall Data From Api
    [Documentation]    Get all essential weather data via one API call for specific arguments and return it
    [Arguments]    ${params}
    ${response}    RequestsLibrary.GET    ${API_ENDPOINT_ONECALL}
    ...                                   ${params}
    RequestsLibrary.Status Should Be    ${CODE_SUCCESS}
    [Return]    ${response}