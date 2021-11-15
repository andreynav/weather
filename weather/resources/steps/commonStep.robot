*** Settings ***
Resource    ../../../import.resource

*** Keywords ***
Open Browser And Maximaze
    [Documentation]    Sets browser and settings for window
    SeleniumLibrary.Open Browser    browser=Chrome
    SeleniumLibrary.Maximize Browser Window

Close Browser
    [Documentation]    Closing the current browser
    SeleniumLibrary.Close Browser

Delete Session
    [Documentation]    Delete current session by removing all cookies
    SeleniumLibrary.Delete All Cookies

Verify Alert Is Displayed
    [Documentation]    The alert with ${text} is displayed
    [Arguments]    ${text}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${ALERT_TITLE_LOCATOR}
    SeleniumLibrary.Wait Until Element Contains    locator=${ALERT_TEXT_LOCATOR}
    ...                                            text=${text}

Verify Unique Page Element
    [Documentation]    Verify the unique page element value
    [Arguments]    ${locator}
    ...            ${value}
    ${currentValue}    common.Get Unique Page Element    ${locator}
    BuiltIn.Should Be Equal    ${currentValue}
    ...                        ${value}
    ...                        The value does not equal required

