*** Settings ***
Library                                             SeleniumLibrary

*** Variables ***
${MAIN_URL}                                         https://home.openweathermap.org/
${MAIN_ARTICLE1_TITLE_LOCATOR}                      //h2[contains(text(),'Historical weather for any location')]
${MAIN_ARTICLE1_TITLE_VALUE}                        Historical weather for any location

*** Keywords ***
Open Main Page
    [Documentation]                                     User opens Main page
    SeleniumLibrary.Go To                               ${MAIN_URL}
    SeleniumLibrary.Wait Until Element Contains         locator=${MAIN_ARTICLE1_TITLE_LOCATOR}     text=${MAIN_ARTICLE1_TITLE_VALUE}

Verify Main Page Is Opened
    [Documentation]                                     The main page is opened
    SeleniumLibrary.Wait Until Location Is              ${MAIN_URL}