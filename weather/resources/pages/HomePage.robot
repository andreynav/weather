*** Settings ***
Resource    ../../../import.resource

*** Variables ***
${HOME_URL}                       https://home.openweathermap.org/
${HOME_ARTICLE1_TITLE_LOCATOR}    //h2[contains(text(),'${HOME_ARTICLE1_TITLE_VALUE}')]
${HOME_ARTICLE1_TITLE_VALUE}      Historical weather for any location

*** Keywords ***
Go To Home Page
    [Documentation]    User opens the Home page
    SeleniumLibrary.Go To    ${HOME_URL}
