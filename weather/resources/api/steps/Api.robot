*** Settings ***
Resource    ../../../../import.resource

*** Keywords ***
Get Temperature From Weather Api
    [Documentation]    Get value of temperature parameter for a city
    [Arguments]    ${json_path}
    ...            ${params}
    ${response}    weather.Get Weather Data From Api    ${params}
    ${temperature}    JSONLibrary.Get Value From Json    ${response.json()}
    ...                                                  ${json_path}
    [Return]    ${temperature[0]}

Get From Onecall Api List Of Items
    [Documentation]    Get array of 8 certain ${item} from onecall endpoint
    [Arguments]    ${item}
    ${json_path}    BuiltIn.Set Variable If
    ...    '${item}' == 'Dates'    ${ONECALL_JSON_PATH.list_dates}
    ...    '${item}' == 'Icons'    ${ONECALL_JSON_PATH.list_icons}
    ...    '${item}' == 'Max_Temperature'    ${ONECALL_JSON_PATH.list_temp_max}
    ...    '${item}' == 'Min_Temperature'    ${ONECALL_JSON_PATH.list_temp_min}
    ...    '${item}' == 'Weather_Description'    ${ONECALL_JSON_PATH.list_description}
    ${response}    Onecall.Get Onecall Data From Api    ${dict_with_days_forecast}
    RequestsLibrary.Status Should Be    ${CODE_SUCCESS}
    ${value}    JSONLibrary.Get Value From Json    ${response.json()}
    ...                                            ${json_path}
    [Return]    ${value}

