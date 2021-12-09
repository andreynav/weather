*** Settings ***
Resource          ../../../import.resource
Suite Setup       CommonStep.Open Browser And Maximaze
Suite Teardown    CommonStep.Close Browser

*** Test Cases ***
Get 8 Days Forecast Sunrise And Sunset
    [Tags]    003
    [Documentation]    User get weather for city via UI and compare to weather via API
    [Setup]    Run Keywords    CommonStep.Begin Test Case
    ...                        Precondition For Test 003

    BuiltIn.Log Many    Step 1: Get weather for city 'Manchester, GB'
    ...                 ER 1: Verify the city name is displayed
    ...                 ER 2: Verify the current date is displayed

    MainStep.Select Measure    C
    MainStep.Search City By Name    ${MANCHESTER}
    MainStep.Verify City Is    ${MANCHESTER}
    CommonStep.Verify Date Is Current    ${CITY_DATE_FORMAT}

    BuiltIn.Log Many    Step 2: Open weather details weather for 8 days via API for city 'Manchester, GB'
    ...                 ER 1: Verify the UI weather sunrise data matches the data from the back-end
    ...                 ER 2: Verify the UI weather sunset data matches the data from the back-end

    BuiltIn.Set Task Variable    ${step2_day}    1
    MainStep.Open Forecast Detail Section For Day    day=${step2_day}
    ${sunrise_ui}    MainStep.Get From Forecast Detail Section Item    item=Sunrise
    ${sunset_ui}    MainStep.Get From Forecast Detail Section Item    item=Sunset
    MainStep.Verify API And UI Detail Section Items Are Matches    api_list_items=${list_sunrise_api}
    ...                                                            ui_item=${sunrise_ui}
    ...                                                            day=${step2_day}
    MainStep.Verify API And UI Detail Section Items Are Matches    api_list_items=${list_sunset_api}
    ...                                                            ui_item=${sunset_ui}
    ...                                                            day=${step2_day}

    BuiltIn.Log Many    Step 3: Select the next day in scrollbar of weather details for 8 days section
    ...                 ER 1: Verify the UI weather sunrise data matches the data from the back-end
    ...                 ER 2: Verify the UI weather sunset data matches the data from the back-end

    MainStep.Select Day And Verify API And UI Data Are Matches    day=2
    MainStep.Select Day And Verify API And UI Data Are Matches    day=3
    MainStep.Select Day And Verify API And UI Data Are Matches    day=4
    MainStep.Select Day And Verify API And UI Data Are Matches    day=5
    MainStep.Select Day And Verify API And UI Data Are Matches    day=6
    MainStep.Select Day And Verify API And UI Data Are Matches    day=7
    MainStep.Select Day And Verify API And UI Data Are Matches    day=8

    BuiltIn.Log Many    Step 4: Select the previouse day in scrollbar of weather details for 8 days section
    ...                 ER 1: Verify the UI weather sunrise data matches the data from the back-end
    ...                 ER 2: Verify the UI weather sunset data matches the data from the back-end

    MainStep.Select Day And Verify API And UI Data Are Matches    day=6
    MainStep.Select Day And Verify API And UI Data Are Matches    day=5
    MainStep.Select Day And Verify API And UI Data Are Matches    day=4

*** Keywords ***
Precondition For Test 003
    [Documentation]    Create the dictionary of parameters and get weather via API
    ${dict_with_days_forecast}    CreateDict.Create Params Dictionary    lat=${COORD_MANCHESTER.lat}
    ...                                                                  lon=${COORD_MANCHESTER.lon}
    ...                                                                  appid=${APP_ID}
    ...                                                                  units=metric
    ...                                                                  exclude=minutely,alerts,hourly
    BuiltIn.Set Test Variable    ${dict_with_days_forecast}
    ${list_dates_api}    Api.Get From Onecall Api List Of Items    item=Dates
    BuiltIn.Set Test Variable    ${list_dates_api}
    ${list_sunrise_api}    Api.Get From Onecall Api List Of Items    item=Sunrise
    BuiltIn.Set Test Variable    ${list_sunrise_api}
    ${list_sunset_api}    Api.Get From Onecall Api List Of Items    item=Sunset
    BuiltIn.Set Test Variable    ${list_sunset_api}
    Common.Accept All Cookies