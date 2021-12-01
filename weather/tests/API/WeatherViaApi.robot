*** Settings ***
Resource          ../../../import.resource

*** Test Cases ***
Get Weather Via Api By Name And Cord And Id
    [Documentation]    Get weather via certain parameters: name, coordinates, id
    [Template]    Get Weather By Parameters And Verify Results
    ${JSON_PATH.lon}    ${COORD_BELMOPAN.lon}    ${{ dict(q="${BELMOPAN}", appid="${APP_ID}") }}
    ${JSON_PATH.lat}    ${COORD_BELMOPAN.lat}    ${{ dict(q="${BELMOPAN}", appid="${APP_ID}") }}
    ${JSON_PATH.name}   ${BELMOPAN}              ${{ dict(lat="${COORD_BELMOPAN.lat}", lon="${COORD_BELMOPAN.lon}", appid="${APP_ID}") }}
    ${JSON_PATH.name}   ${BELMOPAN}              ${{ dict(id="${BELMOPAN_ID}", appid="${APP_ID}") }}

Get Weather Via
    [Documentation]    Get weather via certain parameters: name, units, id
    [Template]    Get City Temperature Via Units And Verify Measure
    ${JSON_PATH.temperature}    q=${BELMOPAN}    appid=${APP_ID}    units=standard
    ${JSON_PATH.temperature}    q=${BELMOPAN}    appid=${APP_ID}    units=metric
    ${JSON_PATH.temperature}    q=${BELMOPAN}    appid=${APP_ID}    units=imperial
    ${JSON_PATH.temperature}    q=${BELMOPAN}    appid=${APP_ID}
    ${JSON_PATH.temperature}    q=${BELMOPAN}    appid=${APP_ID}    units=invalid

*** Keywords ***
Get Weather By Parameters And Verify Results
    [Documentation]    Get weather for a city via certain parameters
    [Arguments]    ${json_path}
    ...            ${expected_result}
    ...            ${params}
    BuiltIn.Log Many    Step 1: Get weather using parameters
    ...                 ER 1: Results are displayed for ${expected_result}
    ${value}    Api.Get Temperature From Weather Api    ${json_path}
    ...                                             ${params}
    BuiltIn.Should Be Equal As Strings   ${value}
    ...                                  ${expected_result}

Get City Temperature Via Units And Verify Measure
    [Documentation]
    [Arguments]    ${json_path}
    ...            ${q}
    ...            ${appid}
    ...            ${units}=None
    BuiltIn.Log Many    Step 1: Get weather for city ${q} using the parameter ${units}
    ...                 ER 1: Temperature is displayed in ${units}
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${q}
    ...                                                                          appid=${appid}
    ...                                                                          units=${units}
    ${temperature_1}    Api.Get Temperature From Weather Api    ${json_path}
    ...                                                     ${dict_with_temperature_measure_1}
    ${measure_temperature_2}    Common.Get Random Measure Except    ${dict_with_temperature_measure_1}[units]
    ${dict_with_temperature_measure_2}    CreateDict.Create Params Dictionary    q=${q}
    ...                                                                          appid=${appid}
    ...                                                                          units=${measure_temperature_2}
    ${temperature_two}    Api.Get Temperature From Weather Api    ${json_path}
    ...                                                       ${dict_with_temperature_measure_2}
    ${converted_temperature_two}    ConvertTemp.Convert Measure Temperature    ${temperature_two}
    ...                                                                        ${measure_temperature_2}
    ...                                                                        ${dict_with_temperature_measure_1}[units]
    BuiltIn.Should Be Equal As Strings    ${temperature_1}
    ...                                   ${converted_temperature_two}



