*** Settings ***
Library                                             SeleniumLibrary

*** Variables ***
${BASE_URL}                                         openweathermap.org

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