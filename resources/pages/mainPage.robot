*** Settings ***
Library                                                 SeleniumLibrary

*** Variables ***
${MAIN_URL}                                             https://home.openweathermap.org/
${MAIN_ARTICLE1_TITLE_LOCATOR}                          //h2[contains(text(),'Historical weather for any location')]
${MAIN_ARTICLE1_TITLE_VALUE}                            Historical weather for any location

*** Keywords ***
Open Main Page
    [Documentation]                                     User opens the Main page
    SeleniumLibrary.Go To                               ${MAIN_URL}
    mainPage.Verify Main Page Is Opened

Verify Main Page Is Opened
    [Documentation]                                     The Main page is opened
    SeleniumLibrary.Wait Until Location Is              ${MAIN_URL}