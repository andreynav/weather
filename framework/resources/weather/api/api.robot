*** Settings ***
Resource    ../../../../import.resource

*** Keywords ***
Get Random Measure Except
    [Documentation]    Get random temperature measure except getting as parameter
    [Arguments]    ${existing_measure}
    ${unit_keys}    Collections.Get Dictionary Keys    ${UNITS}
    ${random_meausure}    RandomList.Get Random Item From List    ${unit_keys}
    ...                                                           ${existing_measure}
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

Get City Temperature Via Units And Verify Measure
    [Documentation]
    [Arguments]    ${json_path}
    ...            ${q}
    ...            ${appid}
    ...            ${units}=None
    BuiltIn.Log Many    Step 1: получить данные о погоде для города ${q} с использованием параметра ${units}
    ...                 ER 1: температура выводится в ${units}
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${q}
    ...                                                                          appid=${appid}
    ...                                                                          units=${units}
    ${temperature_1}    api.Get Value For Specific JPath    ${json_path}
    ...                                                     ${dict_with_temperature_measure_1}
    ${measure_temperature_2}    api.Get Random Measure Except    ${dict_with_temperature_measure_1}[units]
    ${dict_with_temperature_measure_2}    CreateDict.Create Params Dictionary    q=${q}
    ...                                                                          appid=${appid}
    ...                                                                          units=${measure_temperature_2}
    ${temperature_two}    api.Get Value For Specific JPath    ${json_path}
    ...                                                       ${dict_with_temperature_measure_2}
    ${converted_temperature_two}    ConvertTemp.Convert Measure Temperature    ${temperature_two}
    ...                                                                        ${measure_temperature_2}
    ...                                                                        ${dict_with_temperature_measure_1}[units]
    BuiltIn.Should Be Equal As Strings    ${temperature_1}
    ...                                   ${converted_temperature_two}

