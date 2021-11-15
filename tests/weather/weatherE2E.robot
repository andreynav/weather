*** Settings ***
Resource          ../../import.resource
Suite Setup       commonStep.Open Browser And Maximaze
Suite Teardown    commonStep.Close Browser

*** Test Cases ***
Get Weather For City And Compare UI And API Data
    [Tags]    001
    [Documentation]    User get weather for city via UI and compare to weather via API
    [Setup]    Precondition For Test 001

    BuiltIn.Log Many    Step 1: Найти погоду для города Belmopan
    ...                 ER 1: проверить что данные о погоде соответвуют тому что вернулось с backend

    mainStep.Enter Value To Search Field    ${BELMOPAN}
    mainStep.Verify Search Temperature    ${tempViaApi}

    BuiltIn.Log Many    Step 2: Получить данные о погоде через API для города Belmopan в фарингейтах
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${BELMOPAN}
    ...                                                                          appid=${APP_ID}
    ...                                                                          units=imperial
    ${tempViaApi}    api.Get Value For Specific JPath    ${JSON_PATH.temperature}
    ...                                                  ${dict_with_temperature_measure_1}

    BuiltIn.Log Many    Step 3: Изменить формат температуры на imperial    #imperial уже получен на step 2
    ...                 ER 3: проверить что данные о погоде соответвуют тому что вернулось с backend

    [Teardown]    commonStep.Delete Session

*** Keywords ***
Precondition For Test 001
    [Documentation]    Login to the app and get weather for city via API
    loginStep.Go To Sign In Page
    loginStep.Login With Credentials    ${USER_CREDENTIALS.email}
    ...                                 ${USER_CREDENTIALS.password}
    mainStep.Verify Main Page Is Opened
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${BELMOPAN}
    ...                                                                          appid=${APP_ID}
    ...                                                                          units=metric
    ${tempViaApi}    api.Get Value For Specific JPath    ${JSON_PATH.temperature}
    ...                                                  ${dict_with_temperature_measure_1}
    Set Test Variable    ${tempViaApi}