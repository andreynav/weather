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
    ${currentValue}    Common.Get Unique Page Element    ${locator}
    BuiltIn.Should Be Equal    ${currentValue}
    ...                        ${value}
    ...                        The value does not equal required

Begin Test Case
    [Documentation]    Login to the app and to be at the Main page
    LoginStep.Go To Sign In Page
    LoginStep.Login With Credentials    email=${USER_CREDENTIALS.email}
    ...                                 password=${USER_CREDENTIALS.password}
    MainStep.Go To Main Page
    MainStep.Verify Main Page Is Opened

Verify Date Is Current
    [Documentation]    Verify the date is current date
    [Arguments]    ${date_format}
    ${parsedDate}    CustomDatetime.Get Current Date    date_format=${date_format}
    ${parsedDateUI}    MainPage.Get Result City Datetime
    BuiltIn.Should Be Equal As Strings    ${parsedDateUI}
    ...                                   ${parsedDate}
    ...                                   The date is wrong

