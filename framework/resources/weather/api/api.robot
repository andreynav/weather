*** Settings ***
Resource    ../../../../import.resource

*** Keywords ***
Converting Measure Temperature One To Measure Temperature Two
    [Documentation]    Get three params: temperature, current temperature measure, and expected temperature measure,\n
    ...                then convert the first one to another and return the result
    [Arguments]    ${temperature}
    ...            ${current_measure}
    ...            ${expected_measure}
    IF    "${current_measure}" == "standard"
        IF    "${expected_measure}" == "metric"
            ${converted_value}    BuiltIn.Evaluate    round( ${temperature} - 273.15, 2)
        ELSE
            BuiltIn.Log    expected_measure == imperial
            ${converted_value}    BuiltIn.Evaluate    round( ((${temperature} - 273.15) * 9/5 + 32), 2)
        END
    ELSE IF    "${current_measure}" == "metric"
        IF    "${expected_measure}" == "standard"
            ${converted_value}    BuiltIn.Evaluate    round( ${temperature} + 273.15, 2)
        ELSE
            BuiltIn.Log    expected_measure == imperial
            ${converted_value}    BuiltIn.Evaluate    round( (${temperature} * 9/5) + 32, 2)
        END
    ELSE
         BuiltIn.Log    current_measure == imperial
         IF    "${expected_measure}" == "standard"
            ${converted_value}    BuiltIn.Evaluate    round( ((${temperature} - 32) * 5/9) + 273.15, 2)
        ELSE
            BuiltIn.Log    expected_measure == metric
            ${converted_value}    BuiltIn.Evaluate    round( ((${temperature} - 32) * 5/9), 2)
        END
    END
    [Return]    ${converted_value}

Get Random Measure Except
    [Documentation]    Get random temperature measure except getting as parameter
    [Arguments]    ${existing_measure}
    ${unit_keys}    Collections.Get Dictionary Keys    ${UNITS}
    ${random_meausure}    random_list.Get Random Item Except Current From List    ${existing_measure}
    ...                                                                           ${unit_keys}
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

Create Valid Dictionary Of Params
    [Documentation]   Get query params, verify them and create dictionary with valid api parameters
    [Arguments]    ${q}
    ...            ${appid}
    ...            ${units}
    ${params}    BuiltIn.Create Dictionary    q=${q}
    ...                                       appid=${appid}
    ...                                       units=${units}
    ${updated_params}    random_list.Default Param    ${params}
    [Return]    ${updated_params}
