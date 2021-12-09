*** Settings ***
Resource    ../../../import.resource

*** Keywords ***
Go To Main Page
    [Documentation]    User opens the Home page
    MainPage.Go To Main Page
    MainStep.Verify Main Page Is Opened

Verify Main Page Is Opened
    [Documentation]    Verify the Main page is opened by way checking unique element
    CommonStep.Verify Unique Page Element    locator=${MAIN_TITLE_LOCATOR}
    ...                                      value=${MAIN_TITLE_VALUE}

Search City By Name
    [Documentation]    User enters specific value to the search field
    [Arguments]    ${city_name}
    MainPage.Input Search Value    value=${city_name}
    MainPage.Click Search Button
    MainPage.Select Item From Dropdown By City Name    city_name=${city_name}

Verify City Is
    [Documentation]    Verify the selected city is ${city_name}
    [Arguments]    ${city_name}
    BuiltIn.Wait Until Keyword Succeeds    3x
    ...                                    3sec
    ...                                    MainPage.Verify Selected City Is
    ...                                    city=${city_name}

Search City By Name And Verify Date Is Current
    [Documentation]    Search ${city_name} for specify ${measure} and verify that result for current date
    [Arguments]    ${measure}
    ...            ${city_name}
    MainStep.Select Measure    measure=${measure}
    MainStep.Search City By Name    city_name=${city_name}
    MainStep.Verify City Is    city_name=${city_name}
    CommonStep.Verify Date Is Current    date_format=${MAIN_CITY_DATE_FORMAT}

Get Temperature For City
    [Documentation]    User temperature value for selected city
    [Arguments]    ${city_name}
    BuiltIn.Wait Until Keyword Succeeds    3x
    ...                                    3sec
    ...                                    MainPage.Verify Selected City Is
    ...                                    city=${city_name}
    ${temp_ui}    MainPage.Get Search Temperature
    [Return]    ${temp_ui}

Verify API And UI Temperature
    [Documentation]    Verify the API and UI temperatures are equals
    [Arguments]    ${temp_ui}
    ...            ${temp_api}
    ${temp_api}    BuiltIn.Evaluate    round(${temp_api})
    BuiltIn.Should Be Equal As Strings    ${temp_ui}
    ...                                   ${temp_api}
    ...                                   The temperature is wrong

Select Measure
    [Documentation]    User selects ${measure} button
    [Arguments]    ${measure}
    MainPage.Click Measure Button    ${measure}
    BuiltIn.Wait Until Keyword Succeeds    3x
    ...                                    3sec
    ...                                    MainStep.Verify Temperature Measure Is
    ...                                    measure=${measure}

Verify Temperature Measure Is
    [Documentation]    Verify the selected temperature measure
    [Arguments]    ${measure}
    ${parsed_measure}    BuiltIn.Wait Until Keyword Succeeds    3x
    ...                                                         3sec
    ...                                                         MainPage.Get Result Temperature Measure
    BuiltIn.Should Be Equal As Strings    ${parsed_measure}
    ...                                   ${measure}
    ...                                   The measure is wrong

Get From 8 Days Forecast List Of Items
    [Documentation]    Get array of 8 certain ${item} from 8 days forecast section
    [Arguments]    ${item}
    ${locator}    BuiltIn.Set Variable If
    ...    '${item}' == 'Dates'    ${MAIN_FORECAST_LISTDATES_LOCATOR}
    ...    '${item}' == 'Temperature_Range'    ${MAIN_FORECAST_LISTTEMPS_LOCATOR}
    ...    '${item}' == 'Weather_Description'    ${MAIN_FORECAST_LISTDESCR_LOCATOR}
    ${list}    MainPage.Get List Of Forecast Items    locator=${locator}
    [Return]    ${list}

Verify API And UI List Of Forecast Dates Are Matches
    [Documentation]    Verify the API and UI list dates are equals
    [Arguments]    ${api_list}
    ...            ${ui_list}
    ${listFormattedDatesApi}    Common.Format Date From Timestamp    time_stamp_list=${api_list}
    ...                                                              date_format=${MAIN_FORECAST_DAY_FORMAT}
    BuiltIn.Should Be Equal As Strings    ${listFormattedDatesApi}
    ...                                   ${ui_list}
    ...                                   The items is wrong

Verify API And UI List Of Forecast Temperatures Are Matches
    [Documentation]    Verify the API and UI list temperatures are equals
    [Arguments]    ${api_list_max}
    ...            ${api_list_min}
    ...            ${ui_list}
    ${list_temps_api}    Common.Create List Temperature Range From Lists    list_max=${api_list_max}
    ...                                                                     list_min=${api_list_min}
    BuiltIn.Should Be Equal As Strings    ${list_temps_api}
    ...                                   ${ui_list}
    ...                                   The items is wrong

Verify API And UI List Of Forecast Descriptions Are Matches
    [Documentation]    Verify the API and UI list descriptions are equals
    [Arguments]    ${api_list}
    ...            ${ui_list}
    BuiltIn.Should Be Equal As Strings    ${api_list}
    ...                                   ${ui_list}
    ...                                   The items is wrong

Open Forecast Detail Section For Day
    [Documentation]    Open forecast detail section for day number ${day}
    [Arguments]    ${day}
    MainPage.Scroll Until Element Is Displayed    locator=${MAIN_LOGOS_BAR_LOCATOR}
    MainPage.Select Forecast Section Row For Day    ${day}

Get From Forecast Detail Section Item
    [Documentation]    Get certain ${item} from forecast detail section
    [Arguments]    ${item}
    ${item_value}    MainPage.Get Detail Section Value For Item    ${item}
    [Return]    ${item_value}

Verify API And UI Detail Section Items Are Matches
    [Documentation]    Verify the API and UI detail section items are equals
    [Arguments]    ${api_list_items}
    ...            ${ui_item}
    ...            ${day}
    ${list_formatted_item_api}    Common.Format Date From Timestamp    time_stamp_list=${api_list_items}
    ...                                                                date_format=${MAIN_SUNRISE_FORMAT}
    ${computed_day}    BuiltIn.Evaluate    ${day} - 1
    BuiltIn.Should Be Equal As Strings    first=${list_formatted_item_api}[${computed_day}]
    ...                                   second=${ui_item}
    ...                                   msg=The items is wrong
    ...                                   ignore_case=True

Select Day In Forecast List And Verify API And UI Data Are Matches
    [Documentation]    Select {day} and verify that API and UI data are mathes for it
    [Arguments]    ${day}
    MainStep.Open Forecast Detail Section For Day    day=${day}
    ${sunrise_ui}    MainStep.Get From Forecast Detail Section Item    item=Sunrise
    ${sunset_ui}    MainStep.Get From Forecast Detail Section Item    item=Sunset
    MainStep.Verify API And UI Detail Section Items Are Matches    api_list_items=${list_sunrise_api}
    ...                                                            ui_item=${sunrise_ui}
    ...                                                            day=${day}
    MainStep.Verify API And UI Detail Section Items Are Matches    api_list_items=${list_sunset_api}
    ...                                                            ui_item=${sunset_ui}
    ...                                                            day=${day}

Select Scroll Detail Section Day
    [Documentation]    Select ${day} in scroll detail section
    [Arguments]    ${day}
    ${list_formatted_day_api}    Common.Format Date From Timestamp    time_stamp_list=${list_dates_api}
    ...                                                               date_format=${MAIN_FORECAST_DAY_FORMAT}
    ${dict_of_days}    BuiltIn.Evaluate    dict(enumerate(${list_formatted_day_api}, start=1))
    ${day}    BuiltIn.Convert To Number    ${day}
    ${calculated_value_from_dict_api}    Collections.Get From Dictionary    dictionary=${dict_of_days}
    ...                                                                     key=${day}
    MainPage.Scroll Until Element Is Displayed    locator=//li[contains(text(),'${calculated_value_from_dict_api}')]
    SeleniumLibrary.Click Element    locator=//li[contains(text(),'${calculated_value_from_dict_api}')]
    MainPage.Scroll Until Element Is Displayed    locator=${MAIN_LOGOS_BAR_LOCATOR}

Select Day In Scrollbar And Verify API And UI Data Are Matches
    [Documentation]    Select {day} and verify that API and UI data are mathes for it
    [Arguments]    ${day}
    MainStep.Select Scroll Detail Section Day    day=${day}
    ${sunrise_ui}    MainStep.Get From Forecast Detail Section Item    item=Sunrise
    ${sunset_ui}    MainStep.Get From Forecast Detail Section Item    item=Sunset
    MainStep.Verify API And UI Detail Section Items Are Matches    api_list_items=${list_sunrise_api}
    ...                                                            ui_item=${sunrise_ui}
    ...                                                            day=${day}
    MainStep.Verify API And UI Detail Section Items Are Matches    api_list_items=${list_sunset_api}
    ...                                                            ui_item=${sunset_ui}
    ...                                                            day=${day}
