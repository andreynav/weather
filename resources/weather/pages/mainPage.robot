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
    mainPage.Verify Main Page Url

Verify Main Page Url
    [Documentation]                                     The Main page url is
    SeleniumLibrary.Wait Until Location Is              ${MAIN_URL}