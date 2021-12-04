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

Verify City Is
    [Documentation]    Verify the selected city is ${city_name}
    [Arguments]    ${city_name}
    BuiltIn.Wait Until Keyword Succeeds    3x
    ...                                    3sec
    ...                                    MainPage.Verify Selected City Is
    ...                                    city=${city_name}

Get From 8 Days Forecast List Of Items
    [Documentation]    Get array of 8 certain ${item} from 8 days forecast setion
    [Arguments]    ${item}
    ${locator}    BuiltIn.Set Variable If
    ...    '${item}' == 'Dates'    ${MAIN_8DAY_FORECAST_LISTDATES_LOCATOR}
    ...    '${item}' == 'Temperature_Range'    ${MAIN_8DAY_FORECAST_LISTTEMPS_LOCATOR}
    ...    '${item}' == 'Weather_Description'    ${MAIN_8DAY_FORECAST_LISTDESCR_LOCATOR}
    ${list}    MainPage.Get List Of Forecast Items    locator=${locator}
    [Return]    ${list}

Verify API And UI List Of Forecast Dates Are Matches
    [Documentation]    Verify the API and UI list dates are equals
    [Arguments]    ${api_list}
    ...            ${ui_list}
    ${listFormattedDatesApi}    Common.Format Date From Timestamp    time_stamp_list=${api_list}
    ...                                                              date_format=${MAIN_8DAY_FORECAST_DFORMAT}
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
