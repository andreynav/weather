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
