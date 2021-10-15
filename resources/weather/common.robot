*** Settings ***
Library                                             SeleniumLibrary

*** Variables ***
${BASE_URL}                                         openweathermap.org
${ALERT_TITLE_LOCATOR}                              //div[@class='panel-heading']
${ALERT_TEXT_LOCATOR}                               //div[@class='panel-heading']/following-sibling::div

*** Keywords ***
Open Browser And Maximaze
    [Documentation]                                 Sets browser and settings for window
    SeleniumLibrary.Open Browser                    browser=Chrome
    SeleniumLibrary.Maximize Browser Window

Close Browser
    [Documentation]                                 Close Browser by closing the browser
    SeleniumLibrary.Close Browser

Delete Session
    [Documentation]                                 Delete current session by removing all cookies
    SeleniumLibrary.Delete All Cookies

Verify Alert Is Displayed
    [Documentation]                                     The alert with ${text} is displayed
    [Arguments]                                         ${text}
    SeleniumLibrary.Wait Until Element Is Visible       locator=${ALERT_TITLE_LOCATOR}
    SeleniumLibrary.Wait Until Element Contains         locator=${ALERT_TEXT_LOCATOR}  text=${text}