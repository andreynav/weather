*** Settings ***
Resource    ../../../import.resource

*** Variables ***
${MAIN_TITLE_LOCATOR}                               //h1/span
${MAIN_TITLE_VALUE}                                 OpenWeather
${MAIN_SEARCH_LOCATOR}                              //input[@placeholder='Search city']
${MAIN_SEARCH_BUTTON_LOCATOR}                       //button[text()='Search']
${MAIN_TEMPERATURE_CITY_LOCATOR}                    //div[@class='section-content']//h2
${MAIN_DATETIME_CITY_LOCATOR}                       //div[@class='section-content']//span[@class='orange-text']
${MAIN_TEMPERATURE_RESULT_LOCATOR}                  //span[@class='heading']
@{MAIN_SEPARATORS}                                  °    ,
${MAIN_METRIC_BUTTON_LOCATOR}                       //div[contains(text(),"Metric")]
${MAIN_IMPERIAL_BUTTON_LOCATOR}                     //div[contains(text(),"Imperial")]
${MAIN_LOADER_LOCATOR}                              //div[@class='owm-loader']
${MAIN_CITY_DATE_FORMAT}                            %b %-d
${MAIN_FORECAST_DAY_FORMAT}                         %a, %b %d
${MAIN_SUNRISE_FORMAT}                              %I:%M%p
${MAIN_FORECAST_LISTDATES_LOCATOR}                  //ul[@class='day-list']/li/span
${MAIN_FORECAST_LISTTEMPS_LOCATOR}                  //div[@class='day-list-values']/div/span
${MAIN_FORECAST_LISTDESCR_LOCATOR}                  //span[@class='sub']
${MAIN_FORECAST_LISTROWS_LOCATOR}                   //ul[@class='day-list']
${MAIN_FORECAST_SUNRISE_LABEL_LOCATOR}              //span[contains(text(),"Sunrise")]
${MAIN_FORECAST_SUNRISE_VALUE_LOCATOR}              //span[contains(text(),"Sunrise")]/following-sibling::span
${MAIN_FORECAST_SUNSET_LABEL_LOCATOR}               //span[contains(text(),"Sunset")]
${MAIN_FORECAST_SUNSET_VALUE_LOCATOR}               //span[contains(text(),"Sunset")]/following-sibling::span
${MAIN_FORECAST_SCROLCONTAINER_SCHEVRON_LOCATOR}    //div[@class='scrolling-container-header']/span[@class='chevron-container']
${MAIN_LOGOS_BAR_LOCATOR}                           //div[@class='section-content mobile-padding']

*** Keywords ***
Go To Main Page
    [Documentation]    User opens the Main page
    SeleniumLibrary.Go To    ${URL_MAIN}
    MainPage.Wait Main Page Is Loaded

Wait Main Page Is Loaded
    [Documentation]    Wait until the main page is loaded to manipulate the DOM elements
    SeleniumLibrary.Wait Until Element Is Not Visible    locator=${MAIN_LOADER_LOCATOR}
    ...                                                  timeout=15

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

Select Item From Dropdown By City Name
    [Documentation]    User selects the first result which match the ${item} in the dropdown list
    [Arguments]    ${city_name}
    ${locator}    MainPage.Get First Item Locator From Dropdown By City Name    ${city_name}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${locator}
    SeleniumLibrary.Click Element    locator=${locator}

Get First Item Locator From Dropdown By City Name
    [Documentation]    Get the locator for city name in the dropdown list
    [Arguments]    ${city_name}
    ${locator}    BuiltIn.Set Variable    //div[@class="search-container"]/ul/li/span[contains(text(),"${city_name}")]
    [Return]    ${locator}

Get Search Temperature
    [Documentation]    Get the search temperature result
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_TEMPERATURE_RESULT_LOCATOR}
    ${temperature}    SeleniumLibrary.Get Text    locator=${MAIN_TEMPERATURE_RESULT_LOCATOR}
    ${parsedTemperature}    String.Split String    string=${temperature}
    ...                                            separator=${MAIN_SEPARATORS}[0]
    [Return]    ${parsedTemperature}[0]

Get Result Temperature Measure
    [Documentation]    Get the selected measure and return it
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_TEMPERATURE_RESULT_LOCATOR}
    ${temperature}    SeleniumLibrary.Get Text    locator=${MAIN_TEMPERATURE_RESULT_LOCATOR}
    ${parsedMeasure}    String.Split String    string=${temperature}
    ...                                        separator=${MAIN_SEPARATORS}[0]
    [Return]    ${parsedMeasure}[1]

Verify Selected City Is
    [Documentation]    Get the search temperature result if city is ${city}
    [Arguments]    ${city}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_TEMPERATURE_CITY_LOCATOR}
    ${selectedCity}    SeleniumLibrary.Get Text    locator=${MAIN_TEMPERATURE_CITY_LOCATOR}
    BuiltIn.Should Be Equal As Strings    ${selectedCity}
    ...                                   ${city}
    ...                                   The city is wrong

Click Measure Button
    [Documentation]    User clicks the ${measure} button
    [Arguments]    ${measure}
    ${locator}    BuiltIn.Set Variable If
    ...    '${measure}' == 'C'    ${MAIN_METRIC_BUTTON_LOCATOR}
    ...    '${measure}' == 'F'    ${MAIN_IMPERIAL_BUTTON_LOCATOR}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${locator}
    SeleniumLibrary.Click Element    locator=${locator}
    MainPage.Wait Main Page Is Loaded

Get Result City Datetime
    [Documentation]    #TODO:
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_DATETIME_CITY_LOCATOR}
    ${date}    SeleniumLibrary.Get Text    locator=${MAIN_DATETIME_CITY_LOCATOR}
    ${parsedDate}    String.Split String    string=${date}
    ...                                     separator=${MAIN_SEPARATORS}[1]
    [Return]    ${parsedDate}[0]

Get List Of Forecast Items
    [Documentation]    #TODO:
    [Arguments]    ${locator}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${locator}
    SeleniumLibrary.Get Element Count    locator=${locator}
    @{listElements}    SeleniumLibrary.Get WebElements    locator=${locator}
    ${listOfItems}    BuiltIn.Create List
    FOR    ${element}    IN    @{listElements}
        ${value}    SeleniumLibrary.Get Text    ${element}
        Collections.Append To List    ${listOfItems}
        ...                           ${value}
    END
    [Return]    ${listOfItems}

Select Forecast Section Row For Day
    [Documentation]    Select a row with ${number} in 8 day forecast section
    [Arguments]    ${day}
    #MainPage.Scroll Until Element Is Displayed    locator=${MAIN_LOGOS_BAR_LOCATOR}
    ${locator}    MainPage.Get Forecast Detail Section Row Locator For Day    ${day}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${locator}
    SeleniumLibrary.Click Element    locator=${locator}
    MainPage.Wait Detail Section Is Displayed

Scroll Until Element Is Displayed
    [Documentation]    Scroll down until element cannot be displayed on the bottom of the screen
    [Arguments]    ${locator}
    SeleniumLibrary.Scroll Element Into View    locator=${locator}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${locator}

Get Forecast Detail Section Row Locator For Day
    [Documentation]    Get the locator for schevrone ${number} in the forecast detail section
    [Arguments]    ${number}
    #/descendant::span[@class='chevron-container'][${number}]/*[name()='svg']
    ${locator}    BuiltIn.Set Variable    //ul[@class='day-list']/li[${number}]
    [Return]    ${locator}

Wait Detail Section Is Displayed
    [Documentation]    Wait until the detail section is displayed to manipulate the DOM elements
    SeleniumLibrary.Element Attribute Value Should Be    locator=${MAIN_FORECAST_LISTROWS_LOCATOR}
    ...                                                  attribute=style
    ...                                                  expected=display: none;
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_FORECAST_SUNRISE_LABEL_LOCATOR}

Get Detail Section Value For Item
    [Documentation]    Get the value of the ${item} in the detail section and return it
    [Arguments]    ${item}
    ${locator}    BuiltIn.Set Variable If
    ...    '${item}' == 'Sunrise'    ${MAIN_FORECAST_SUNRISE_VALUE_LOCATOR}
    ...    '${item}' == 'Sunset'    ${MAIN_FORECAST_SUNSET_VALUE_LOCATOR}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${locator}
    ${item_value}    SeleniumLibrary.Get Text    locator=${locator}
    [Return]    ${item_value}

#Scroll To Element    не нужен
#    [Arguments]  ${locator}
#    ${x}    SeleniumLibrary.Get Horizontal Position  ${locator}
#    ${y}    SeleniumLibrary.Get Vertical Position    ${locator}
#    ${newY}    BuiltIn.Evaluate    ${y}-100
#    SeleniumLibrary.Execute Javascript  window.scrollTo(${x}, ${newY})