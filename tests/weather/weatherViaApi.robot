*** Settings ***
Resource          ../../import.resource

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
    BuiltIn.Log Many    Step 1: получить данные о погоде с использованием параметров
    ...                 ER 1: результаты выводится для ${expected_result}
    ${value}    api.Get Value For Specific JPath    ${json_path}
    ...                                             ${params}
    BuiltIn.Should Be Equal As Strings   ${value}
    ...                                  ${expected_result}

Get City Temperature Via Units And Verify Measure
    [Documentation]
    [Arguments]    ${json_path}
    ...            ${q}
    ...            ${appid}
    ...            ${units}=None
    BuiltIn.Log Many    Step 1: получить данные о погоде для города ${q} с использованием параметра ${units}
    ...                 ER 1: температура выводится в ${units}
    ${dictionary_with_temperature_measure_one}    CreateDict.Create Dictionary Of Units Params    q=${q}
    ...                                                                                           appid=${appid}
    ...                                                                                           units=${units}
    ${temperature_one}    api.Get Value For Specific JPath    ${json_path}
    ...                                                       ${dictionary_with_temperature_measure_one}
    ${measure_temperature_two}    api.Get Random Measure Except    ${dictionary_with_temperature_measure_one}[units]
    ${dictionary_with_temperature_measure_two}    CreateDict.Create Dictionary Of Units Params    q=${q}
    ...                                                                                           appid=${appid}
    ...                                                                                           units=${measure_temperature_two}
    ${temperature_two}    api.Get Value For Specific JPath    ${json_path}
    ...                                                       ${dictionary_with_temperature_measure_two}
    ${converted_temperature_two_to_temperature_one}    ConvertTemp.Converting Measure Temperature One To Measure Temperature Two    ${temperature_two}
    ...                                                                                                                                             ${measure_temperature_two}
    ...                                                                                                                                             ${dictionary_with_temperature_measure_one}[units]
    BuiltIn.Should Be Equal As Strings    ${temperature_one}
    ...                                   ${converted_temperature_two_to_temperature_one}



