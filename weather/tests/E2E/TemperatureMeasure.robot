*** Settings ***
Resource          ../../../import.resource
Suite Setup       CommonStep.Open Browser And Maximaze
Suite Teardown    CommonStep.Close Browser

*** Test Cases ***
Get Temperature For City And Compare UI And API Data
    [Tags]    001
    [Documentation]    User get weather for city via UI and compare to weather via API
    [Setup]    Run Keywords    CommonStep.Begin Test Case
    ...                        Precondition For Test 001

    BuiltIn.Log Many    Step 1: Get weather for city 'Belmopan'
    ...                 ER 1: Verify the weather data matches the data from the back-end

    MainStep.Select Measure    measure=C
    MainStep.Search City By Name    city_name=${BELMOPAN}
    ${temp_ui}    MainStep.Get Temperature For City    city_name=${BELMOPAN}
    MainStep.Verify API And UI Temperature    temp_ui=${temp_ui}
    ...                                       temp_api=${temp_via_api}

    BuiltIn.Log Many    Step 2: Get weather via API in 'Fahrenheit' for city 'Belmopan'
    ${temp_fahrenheit_api}    Api.Get Temperature From Weather Api    json_path=${JSON_PATH.temperature}
    ...                                                               params=${dict_with_temperature_measure_2}

    BuiltIn.Log Many    Step 3: Change the temperature to 'Fahrenheit'
    ...                 ER 1: Verify the weather data matches the data from the back-end

    MainStep.Select Measure    measure=F
    ${temp_ui}    MainStep.Get Temperature For City    city_name=${BELMOPAN}
    MainStep.Verify API And UI Temperature    temp_ui=${temp_ui}
    ...                                       temp_api=${temp_fahrenheit_api}

    [Teardown]    Run Keywords    User Logout Site
    ...                           CommonStep.Delete Session

*** Keywords ***
Precondition For Test 001
    [Documentation]    Create the dictionaries of parameters
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${BELMOPAN}
    ...                                                                          appid=${APP_ID}
    ...                                                                          units=metric
    ${temp_via_api}    Api.Get Temperature From Weather Api    json_path=${JSON_PATH.temperature}
    ...                                                        params=${dict_with_temperature_measure_1}
    BuiltIn.Set Test Variable    ${temp_via_api}
    ${dict_with_temperature_measure_2}    CreateDict.Create Params Dictionary    q=${BELMOPAN}
    ...                                                                          appid=${APP_ID}
    ...                                                                          units=imperial
    BuiltIn.Set Test Variable    ${dict_with_temperature_measure_2}

