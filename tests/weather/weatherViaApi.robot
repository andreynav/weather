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
    ${JSON_PATH.temperature}    q=${BELMOPAN}    appid=${APP_ID}    units=
    ${JSON_PATH.temperature}    q=${BELMOPAN}    appid=${APP_ID}    units=invalid

*** Keywords ***
Get Weather By Parameters And Verify Results
    [Documentation]    Get weather for a city via certain parameters
    [Arguments]    ${jsonPath}
    ...            ${expectedResult}
    ...            ${params}
    BuiltIn.Log Many    Step 1: получить данные о погоде с использованием параметров
    ...                 ER 1: результаты выводится для ${expectedResult}
    ${value}    api.Get Value For Specific JPath    ${jsonPath}
    ...                                             ${params}
    BuiltIn.Should Be Equal As Strings   ${value}
    ...                                  ${expectedResult}

Get City Temperature Via Units And Verify Measure
    [Documentation]
    [Arguments]    ${jsonPath}
    ...            ${q}
    ...            ${appid}
    ...            ${units}
    BuiltIn.Log Many    Step 1: получить данные о погоде для города ${q} с использованием параметра ${units}
    ...                 ER 1: температура выводится в ${units}
    ${params1}    api.Create Valid Dictionary Of Params    q=${q}
    ...                                                    appid=${appid}
    ...                                                    units=${units}
    ${temp1}    api.Get Value For Specific JPath    ${jsonPath}
    ...                                             ${params1}
    ${measureTemp2}    api.Get Random Measure Except    ${params1}[units]
    ${params2}    api.Create Valid Dictionary Of Params    q=${q}
    ...                                                    appid=${appid}
    ...                                                    units=${measureTemp2}
    ${temp2}    api.Get Value For Specific JPath    ${jsonPath}
    ...                                             ${params2}
    ${convertedTemp2ToTemp1}    api.Converting Measure Temp1 To Measure Temp2    ${temp2}
    ...                                                                          ${measureTemp2}
    ...                                                                          ${params1}[units]
    BuiltIn.Should Be Equal As Strings    ${temp1}
    ...                                   ${convertedTemp2ToTemp1}



