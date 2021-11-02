*** Settings ***
Resource          ../../import.resource

*** Test Cases ***
Get Weather Via Api By Name And Cord And Id
    [Documentation]    Get weather via certain parameters: name, coordinates, id
    [Template]    Get Weather By Parameters And Verify Results
    #path               expResult                params
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
#Get Weather By Parameters And Verify Results
#    [Documentation]    Get weather for a city via certain parameters
#    [Arguments]    ${jsonPath}
#    ...            ${expectedResult}
#    ...            ${params}
#    ${response}    GET    ${API_URL}
#    ...                   ${params}
#    RequestsLibrary.Status Should Be    ${CODE_SUCCESS}
#    ${value}    Get Value From Json    ${response.json()}
#    ...                                ${jsonPath}
#    BuiltIn.Should Be Equal As Strings   ${value[0]}
#    ...                                  ${expectedResult}


