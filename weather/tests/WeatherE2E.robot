*** Settings ***
Resource          ../../import.resource
Suite Setup       CommonStep.Open Browser And Maximaze
Suite Teardown    CommonStep.Close Browser

*** Test Cases ***
Get Weather For City And Compare UI And API Data
    [Tags]    001
    [Documentation]    User get weather for city via UI and compare to weather via API
    [Setup]    Precondition For Test 001

    BuiltIn.Log Many    Step 1: Get weather for city 'Belmopan'
    ...                 ER 1: Verify the weather data matches the data from the back-end

    HomeStep.Enter Value To Search Field    ${BELMOPAN}
    HomeStep.Verify Search Temperature    ${tempViaApi}

    BuiltIn.Log Many    Step 2: Get weather via API in 'Fahrenheit' for city 'Belmopan'
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${BELMOPAN}
    ...                                                                          appid=${APP_ID}
    ...                                                                          units=imperial
    ${tempViaApi}    Api.Get Value For Specific JPath    ${JSON_PATH.temperature}
    ...                                                  ${dict_with_temperature_measure_1}

    BuiltIn.Log Many    Step 3: Change the temperature to 'Celsius'
    ...                 ER 1: Verify the weather data matches the data from the back-end

    [Teardown]    CommonStep.Delete Session

*** Keywords ***
Precondition For Test 001
    [Documentation]    Login to the app and get weather for city via API
    LoginStep.Go To Sign In Page
    LoginStep.Login With Credentials    ${USER_CREDENTIALS.email}
    ...                                 ${USER_CREDENTIALS.password}
    HomeStep.Verify Main Page Is Opened
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${BELMOPAN}
    ...                                                                          appid=${APP_ID}
    ...                                                                          units=metric
    ${tempViaApi}    Api.Get Value For Specific JPath    ${JSON_PATH.temperature}
    ...                                                  ${dict_with_temperature_measure_1}
    Set Test Variable    ${tempViaApi}