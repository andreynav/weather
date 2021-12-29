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

    MainStep.Search City By Name And Verify City Name Is Displayed    measure=C
    ...                                                               city_name=${MANCHESTER}
    CommonStep.Verify Date Is Current    date_format=${MAIN_CITY_DATE_FORMAT}

    BuiltIn.Log Many    Step 2: Open weather details weather for 8 days via API for city 'Manchester, GB'
    ...                 ER 1: Verify the UI weather sunrise data matches the data from the back-end
    ...                 ER 2: Verify the UI weather sunset data matches the data from the back-end

    MainStep.Select Day In Forecast List And Verify API And UI Data Are Matches    day=1

    BuiltIn.Log Many    Step 3: Select the next day in scrollbar of weather details for 8 days section
    ...                 ER 1: Verify the UI weather sunrise data matches the data from the back-end
    ...                 ER 2: Verify the UI weather sunset data matches the data from the back-end

    MainStep.Select Day In Scrollbar And Verify API And UI Data Are Matches    list_days=@{list_days_next}

    BuiltIn.Log Many    Step 4: Select the previouse day in scrollbar of weather details for 8 days section
    ...                 ER 1: Verify the UI weather sunrise data matches the data from the back-end
    ...                 ER 2: Verify the UI weather sunset data matches the data from the back-end

    MainStep.Select Day In Scrollbar And Verify API And UI Data Are Matches    list_days=@{list_days_prev}

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
    ${list_sunrise_api}    Api.Get From Onecall Api List Of Items    item=Sunrise
    ${list_sunset_api}    Api.Get From Onecall Api List Of Items    item=Sunset
    @{list_days_next}    BuiltIn.Create List    2    3    4    5    6    7    8
    @{list_days_prev}    BuiltIn.Create List    7    6    5    4    3    2
    Common.Accept All Cookies
    BuiltIn.Set Test Variable    ${list_dates_api}
    BuiltIn.Set Test Variable    ${list_sunrise_api}
    BuiltIn.Set Test Variable    ${list_sunset_api}
    BuiltIn.Set Test Variable    @{list_days_next}
    BuiltIn.Set Test Variable    @{list_days_prev}
