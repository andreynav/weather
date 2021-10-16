*** Settings ***
Resource    ../../import.robot

*** Keywords ***
Open Browser And Maximaze
    [Documentation]    Sets browser and settings for window
    common.Open Browser And Maximaze

Close Browser
    [Documentation]    Close Browser by closing the browser
    common.Close Browser

Delete Session
    [Documentation]    Delete current session by removing all cookies
    common.Delete Session

Verify Alert Is Displayed
    [Documentation]    Verify the alert with ${text} is displayed
    [Arguments]    ${text}
    common.Verify Alert Is Displayed    ${text}