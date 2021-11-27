*** Settings ***
Resource    ../../import.resource

*** Variables ***
${BASE_URL}               openweathermap.org
${ALERT_TITLE_LOCATOR}    //div[@class='panel-heading']
${ALERT_TEXT_LOCATOR}     //div[@class='panel-heading']/following-sibling::div

*** Keywords ***
Get Unique Page Element
    [Documentation]    Get unique page element
    [Arguments]    ${locator}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${locator}
    ${value}    SeleniumLibrary.Get Text    locator=${locator}
    [Return]    ${value}

Get Random Measure Except
    [Documentation]    Get random temperature measure from exisitng measures except getting as parameter
    [Arguments]    ${existing_measure}
    ${unit_keys}    Collections.Get Dictionary Keys    ${UNITS}
    ${random_meausure}    RandomList.Get Random Item From List    ${unit_keys}
    ...                                                           ${existing_measure}
    [Return]    ${random_meausure}
