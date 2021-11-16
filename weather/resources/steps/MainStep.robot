*** Settings ***
Resource    ../../../import.resource

*** Keywords ***
Go To Main Page
    [Documentation]    User opens the Main page
    MainPage.Go To Main Page
    MainStep.Verify Main Page Is Opened

Verify Main Page Is Opened
    [Documentation]    Verify the main page is opened by way checking unique element
    CommonStep.Verify Unique Page Element    locator=${MAIN_ARTICLE1_TITLE_LOCATOR}
    ...                                      value=${MAIN_ARTICLE1_TITLE_VALUE}

Enter Value To Search Field
    [Documentation]    User enters specific value to the search field
    [Arguments]    ${value}
    MainPage.Input Search Value    ${value}
    SeleniumLibrary.Press Keys    None    RETURN

Verify Search Temperature
    [Documentation]    Verify the search temperature result to API temperature
    [Arguments]    ${temperatureAPI}
    ${temperatureAPI}    BuiltIn.Evaluate    round(float(${temperatureAPI}), 1)
    ${temperatureAPI}    BuiltIn.Convert To String    ${temperatureAPI}
    ${temperatureUI}    MainPage.Get Search Temperature
    BuiltIn.Should Be Equal As Strings    ${temperatureUI}
    ...                                   ${temperatureAPI}
    ...                                   The temperature is wrong