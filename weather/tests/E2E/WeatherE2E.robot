*** Settings ***
Resource          ../../../import.resource
Suite Setup       CommonStep.Open Browser And Maximaze
Suite Teardown    CommonStep.Close Browser

*** Test Cases ***
Get Weather For City And Compare UI And API Data
    [Tags]    001
    [Documentation]    User get weather for city via UI and compare to weather via API
    [Setup]    Run Keywords    CommonStep.Begin Test Case
    ...                        Precondition For Test 001

    BuiltIn.Log Many    Step 1: Get weather for city 'Belmopan'
    ...                 ER 1: Verify the weather data matches the data from the back-end

    MainStep.Select Measure    C
    MainStep.Search City By Name    ${BELMOPAN}
    ${temp_ui}    MainStep.Get Temperature For City    ${BELMOPAN}
    MainStep.Verify API And UI Temperature    ${temp_ui}
    ...                                       ${temp_via_api}

    BuiltIn.Log Many    Step 2: Get weather via API in 'Fahrenheit' for city 'Belmopan'
    ${temp_fahrenheit_api}    Api.Get Temperature From Weather Api    ${JSON_PATH.temperature}
    ...                                                               ${dict_with_temperature_measure_1}

    BuiltIn.Log Many    Step 3: Change the temperature to 'Fahrenheit'
    ...                 ER 1: Verify the weather data matches the data from the back-end

    MainStep.Select Measure    F
    ${temp_ui}    MainStep.Get Temperature For City    ${BELMOPAN}
    MainStep.Verify API And UI Temperature    ${temp_ui}
    ...                                       ${temp_fahrenheit_api}

    [Teardown]    Run Keywords    User Logout Site
    ...                           CommonStep.Delete Session

Get 8 Days Forecast
    [Tags]    002
    [Documentation]    User get weather for city via UI and compare to weather via API
    [Setup]    Run Keywords    CommonStep.Begin Test Case
    ...                        Precondition For Test 002

    BuiltIn.Log Many    Step 1: Get weather for city 'Manchester, GB'
    ...                 ER 1: Verify the city name is displayed
    ...                 ER 2: Verify the current date is displayed

    MainStep.Select Measure    C
    MainStep.Search City By Name    ${MANCHESTER}
    MainStep.Verify City Is    ${MANCHESTER}
    CommonStep.Verify Date Is Current    ${CITY_DATE_FORMAT}

    BuiltIn.Log Many    Step 2: Get weather for 8 days via API for city 'Manchester, GB'
    ...                 ER 1: Verify the UI weather data (date) matches the data from the back-end
    ...                 ER 2: Verify the UI weather data (tempearature) matches the data from the back-end
    ...                 ER 3: Verify the UI weather data (weather description) matches the data from the back-end

    ${list_dates_api}    Api.Get From Onecall Api List Of Items    item=Dates
    ${list_temp_max_api}    Api.Get From Onecall Api List Of Items    item=Max_Temperature
    ${list_temp_min_api}    Api.Get From Onecall Api List Of Items    item=Min_Temperature
    ${list_descriptions_api}    Api.Get From Onecall Api List Of Items    item=Weather_Description

    ${list_dates_ui}    MainStep.Get From 8 Days Forecast List Of Items    item=Dates
    ${list_temps_ui}    MainStep.Get From 8 Days Forecast List Of Items    item=Temperature_Range
    ${list_descriptions_ui}    MainStep.Get From 8 Days Forecast List Of Items    item=Weather_Description

    MainStep.Verify API And UI List Of Forecast Dates Are Matches    api_list=${list_dates_api}
    ...                                                              ui_list=${list_dates_ui}
    MainStep.Verify API And UI List Of Forecast Temperatures Are Matches    api_list_max=${list_temp_max_api}
    ...                                                                     api_list_min=${list_temp_min_api}
    ...                                                                     ui_list=${list_temps_ui}
    MainStep.Verify API And UI List Of Forecast Descriptions Are Matches    api_list=${list_descriptions_api}
    ...                                                                     ui_list=${list_descriptions_ui}

    [Teardown]    Run Keywords    User Logout Site
    ...                           CommonStep.Delete Session

*** Keywords ***
Precondition For Test 001
    [Documentation]    Create the dictionaries of parameters
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${BELMOPAN}
    ...                                                                          appid=${APP_ID}
    ...                                                                          units=metric
    ${temp_via_api}    Api.Get Temperature From Weather Api    ${JSON_PATH.temperature}
    ...                                                        ${dict_with_temperature_measure_1}
    Set Test Variable    ${temp_via_api}
    ${dict_with_temperature_measure_1}    CreateDict.Create Params Dictionary    q=${BELMOPAN}
    ...                                                                          appid=${APP_ID}
    ...                                                                          units=imperial
    Set Test Variable    ${dict_with_temperature_measure_1}

Precondition For Test 002
    [Documentation]    Create the dictionary of parameters
    ${dict_with_days_forecast}    CreateDict.Create Params Dictionary    lat=${COORD_MANCHESTER.lat}
    ...                                                                  lon=${COORD_MANCHESTER.lon}
    ...                                                                  appid=${APP_ID}
    ...                                                                  units=metric
    ...                                                                  exclude=minutely,alerts,hourly
    Set Test Variable    ${dict_with_days_forecast}