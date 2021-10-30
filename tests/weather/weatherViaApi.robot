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

Get Weather Via Api By Name And Units
    [Documentation]    Get weather via certain parameters: name, units
    [Template]    Get Weather By Parameters
    ${JSON_PATH.temperature}    ${{ dict(q="${BELMOPAN}", units="standard", appid="${APP_ID}") }}
    ${JSON_PATH.temperature}    ${{ dict(q="${BELMOPAN}", units="metric", appid="${APP_ID}") }}
    ${JSON_PATH.temperature}    ${{ dict(q="${BELMOPAN}", units="imperial", appid="${APP_ID}") }}
    ${JSON_PATH.temperature}    ${{ dict(q="${BELMOPAN}", appid="${APP_ID}") }}
    ${JSON_PATH.temperature}    ${{ dict(q="${BELMOPAN}", units="invalid", appid="${APP_ID}") }}



