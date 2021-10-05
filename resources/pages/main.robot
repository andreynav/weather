*** Settings ***
Library                             SeleniumLibrary

*** Variables ***
${baseUrl}                          https://openweathermap.org/

*** Keywords ***
Begin Test
    [Documentation]                 Sets browser and settings for window
    Open Browser                    browser=Chrome
    Maximize Browser Window

End Test
    [Documentation]                 End test by closing the browser
    Close Browser