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

Enter Value To Search City
    [Documentation]    User enters specific value to the search field
    [Arguments]    ${cityName}
    MainPage.Input Search Value    ${cityName}
    MainPage.Click Search Button
    MainPage.Select Item From Dropdown

Get Temperature For City
    [Documentation]    User temperature value for selected city
    [Arguments]    ${cityName}
    BuiltIn.Wait Until Keyword Succeeds    10 x    1 sec    MainPage.Get Selected City    ${cityName}
    ${tempUI}    MainPage.Get Search Temperature
    [Return]    ${tempUI}

Verify API And UI Temperature
    [Documentation]    Verify the API and UI temperatures are equals
    [Arguments]    ${tempUI}
    ...            ${tempAPI}
    ${tempAPI}    BuiltIn.Evaluate    round(${tempAPI})
    BuiltIn.Should Be Equal As Strings    ${tempUI}
    ...                                   ${tempAPI}
    ...                                   The temperature is wrong

Select Measure
    [Documentation]    User selects ${measure} button
    [Arguments]    ${measure}
    MainPage.Click Measure Button    ${measure}
    BuiltIn.Wait Until Keyword Succeeds    10 x    1 sec    MainStep.Verify Temperature Measure Is    ${measure}

Verify Temperature Measure Is
    [Documentation]    Verify the selected temperature measure
    [Arguments]    ${measure}
    ${parsedMeasure}    BuiltIn.Wait Until Keyword Succeeds    10 x    1 sec    MainPage.Get Selected Measure
    BuiltIn.Should Be Equal As Strings    ${parsedMeasure}
    ...                                   ${measure}
    ...                                   The measure is wrong
