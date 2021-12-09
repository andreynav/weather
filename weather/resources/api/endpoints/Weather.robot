*** Settings ***
Resource    ../../../../import.resource

*** Keywords ***
Get Weather Data From Api
    [Documentation]    Get weather data via API for specific arguments and return it
    [Arguments]    ${params}
    ${response}    RequestsLibrary.GET    url=${API_ENDPOINT_WEATHER}
    ...                                   params=${params}
    RequestsLibrary.Status Should Be    expected_status=${CODE_SUCCESS}
    [Return]    ${response}
