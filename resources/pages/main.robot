*** Settings ***
Library                                             SeleniumLibrary

*** Variables ***
${MAIN_URL}                                         https://openweathermap.org/

*** Keywords ***
Begin Test
    [Documentation]                                 Sets browser and settings for window
    SeleniumLibrary.Open Browser                    browser=Chrome
    SeleniumLibrary.Maximize Browser Window

End Test
    [Documentation]                                 End test by closing the browser
    SeleniumLibrary.Close Browser