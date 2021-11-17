*** Settings ***
Resource    ../../../import.resource

*** Variables ***
${HOME_URL}                       https://home.openweathermap.org/
${HOME_ARTICLE1_TITLE_LOCATOR}    //h2[contains(text(),'Historical weather for any location')]
${HOME_ARTICLE1_TITLE_VALUE}      Historical weather for any location
${HOME_SEARCH_LOCATOR}            //*[@name="q"]
${TEMPERATURE_RESULT_LOCATOR}     //span[contains(text(),'°С ')]
${SEPARATOR}                      °

*** Keywords ***
Go To Main Page
    [Documentation]    User opens the Main page
    SeleniumLibrary.Go To    ${HOME_URL}

Input Search Value
    [Documentation]    User inputs the searching value
    [Arguments]    ${value}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${HOME_SEARCH_LOCATOR}
    SeleniumLibrary.Input Text    locator=${HOME_SEARCH_LOCATOR}
    ...                           text=${value}

Get Search Temperature
    [Documentation]    Get the search temperature result
    SeleniumLibrary.Wait Until Element Is Visible    locator=${TEMPERATURE_RESULT_LOCATOR}
    ${temperature}    SeleniumLibrary.Get Text    locator=${TEMPERATURE_RESULT_LOCATOR}
    ${parsedTemperature}    CustomString.Get Split String    ${temperature}    ${SEPARATOR}    0
    [Return]    ${parsedTemperature}

