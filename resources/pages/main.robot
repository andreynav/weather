*** Settings ***
Library                             SeleniumLibrary

*** Variables ***
${baseUrl}                          https://openweathermap.org/

*** Keywords ***
Begin Test
    Open Browser                    browser=Chrome
    Maximize Browser Window

End Test
    Close Browser