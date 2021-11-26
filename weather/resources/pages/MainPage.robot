*** Settings ***
Resource    ../../../import.resource

*** Variables ***
${MAIN_URL}                             https://openweathermap.org/
${MAIN_TITLE_LOCATOR}                   //h1/span
${MAIN_TITLE_VALUE}                     OpenWeather
${MAIN_SEARCH_LOCATOR}                  //input[@placeholder='Search city']
${MAIN_SEARCH_BUTTON_LOCATOR}           //button[text()='Search']
${MAIN_DROPDOWN_ITEM_LOCATOR}           //div[@class='search-container']/ul/li
${MAIN_TEMPERATURE_CITY_LOCATOR}        //div[@class='section-content']//h2
${MAIN_TEMPERATURE_RESULT_LOCATOR}      //span[@class='heading']
${SEPARATOR_1}                          °
${SEPARATOR_2}                          ,
${MAIN_METRIC_BUTTON_LOCATOR}           //div[contains(text(),"Metric")]
${MAIN_IMPERIAL_BUTTON_LOCATOR}         //div[contains(text(),"Imperial")]
${MAIN_LOADER_LOCATOR}                  //div[@class='owm-loader']

*** Keywords ***
Go To Main Page
    [Documentation]    User opens the Main page
    SeleniumLibrary.Go To    ${MAIN_URL}

Input Search Value
    [Documentation]    User inputs the searching value
    [Arguments]    ${value}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_SEARCH_LOCATOR}
    SeleniumLibrary.Input Text    locator=${MAIN_SEARCH_LOCATOR}
    ...                           text=${value}

Click Search Button
    [Documentation]    User clicks the button Search
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_SEARCH_BUTTON_LOCATOR}
    SeleniumLibrary.Click Element    locator=${MAIN_SEARCH_BUTTON_LOCATOR}

Select Item From Dropdown
    [Documentation]    User selects the item from the dropdown list
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_DROPDOWN_ITEM_LOCATOR}
    SeleniumLibrary.Click Element    locator=${MAIN_DROPDOWN_ITEM_LOCATOR}

Get Search Temperature
    [Documentation]    Get the search temperature result
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_TEMPERATURE_RESULT_LOCATOR}
    ${temperature}    SeleniumLibrary.Get Text    locator=${MAIN_TEMPERATURE_RESULT_LOCATOR}
    ${parsedTemperature}    String.Split String    string=${temperature}    separator=${SEPARATOR_1}
    [Return]    ${parsedTemperature}[0]

Get Selected Measure
    [Documentation]    Get the selected measure and return it
    [Arguments]    ${measure}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_TEMPERATURE_RESULT_LOCATOR}
    ${temperature}    SeleniumLibrary.Get Text    locator=${MAIN_TEMPERATURE_RESULT_LOCATOR}
    ${parsedMeasure}    String.Split String    string=${temperature}    separator=${SEPARATOR_1}
    [Return]    ${parsedMeasure}[1]

Get Selected City
    [Documentation]    Get the search temperature result if city is ${city}
    [Arguments]    ${city}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_TEMPERATURE_CITY_LOCATOR}
    ${selectedCity}    SeleniumLibrary.Get Text    locator=${MAIN_TEMPERATURE_CITY_LOCATOR}
    ${parsedSelectedCity}    String.Split String    string=${selectedCity}    separator=${SEPARATOR_2}
    BuiltIn.Should Be Equal As Strings    ${parsedSelectedCity}[0]
    ...                                   ${city}
    ...                                   The city is wrong

Click Measure Button
    [Documentation]    User clicks the ${measure} button
    [Arguments]    ${measure}
    ${locator}    BuiltIn.Set Variable If
    ...    '${measure}' == 'C'    ${MAIN_METRIC_BUTTON_LOCATOR}
    ...    '${measure}' == 'F'    ${MAIN_IMPERIAL_BUTTON_LOCATOR}
    SeleniumLibrary.Wait Until Element Is Not Visible    ${MAIN_LOADER_LOCATOR}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${locator}
    SeleniumLibrary.Click Element    locator=${locator}
    SeleniumLibrary.Wait Until Element Is Not Visible    ${MAIN_LOADER_LOCATOR}