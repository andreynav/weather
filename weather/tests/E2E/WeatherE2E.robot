*** Settings ***
Resource          ../../../import.resource
Suite Setup       CommonStep.Open Browser And Maximaze
Suite Teardown    CommonStep.Close Browser

*** Test Cases ***
Get Weather For City And Compare UI And API Data
    [Tags]    001
    [Documentation]    User get weather for city via UI and compare to weather via API
    [Setup]    Precondition For Test 001

    BuiltIn.Log Many    Step 1: Get weather for city 'Belmopan'
    ...                 ER 1: Verify the weather data matches the data from the back-end    #add select matric mesure

    MainStep.Select Measure    C
    MainStep.Search City By Name    ${BELMOPAN}
    ${tempUI}    MainStep.Get Temperature For City    ${BELMOPAN}
    MainStep.Verify API And UI Temperature    ${tempUI}
    ...                                       ${tempViaApi}

    BuiltIn.Log Many    Step 2: Get weather via API in 'Fahrenheit' for city 'Belmopan'
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${BELMOPAN}
    ...                                                                          appid=${APP_ID}
    ...                                                                          units=imperial
    ${tempViaApiInFahrenheit}    Api.Get Temperature From Weather Api    ${JSON_PATH.temperature}
    ...                                                              ${dict_with_temperature_measure_1}

    BuiltIn.Log Many    Step 3: Change the temperature to 'Fahrenheit'
    ...                 ER 1: Verify the weather data matches the data from the back-end

    MainStep.Select Measure    F
    ${tempUI}    MainStep.Get Temperature For City    ${BELMOPAN}
    MainStep.Verify API And UI Temperature    ${tempUI}
    ...                                       ${tempViaApiInFahrenheit}

    [Teardown]    CommonStep.Delete Session

*** Keywords ***
Precondition For Test 001
    [Documentation]    Login to the app and get weather for city via API
    LoginStep.Go To Sign In Page
    LoginStep.Login With Credentials    ${USER_CREDENTIALS.email}
    ...                                 ${USER_CREDENTIALS.password}
    MainStep.Go To Main Page
    MainStep.Verify Main Page Is Opened
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${BELMOPAN}
    ...                                                                          appid=${APP_ID}
    ...                                                                          units=metric
    ${tempViaApi}    Api.Get Temperature From Weather Api    ${JSON_PATH.temperature}
    ...                                                  ${dict_with_temperature_measure_1}
    Set Test Variable    ${tempViaApi}