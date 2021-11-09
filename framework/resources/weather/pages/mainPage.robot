*** Settings ***
Resource    ../../import.resource

*** Variables ***
${MAIN_URL}                       https://home.openweathermap.org/
${MAIN_ARTICLE1_TITLE_LOCATOR}    //h2[contains(text(),'Historical weather for any location')]
${MAIN_ARTICLE1_TITLE_VALUE}      Historical weather for any location
${MAIN_SEARCH_LOCATOR}            //*[@name="q"]
${TEMPERATURE_RESULT_LOCATOR}     //span[contains(text(),'°С ')]

*** Keywords ***
Go To Main Page
    [Documentation]    User opens the Main page
    SeleniumLibrary.Go To    ${MAIN_URL}

Input Search Value
    [Documentation]    User inputs the searching value
    [Arguments]    ${value}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${MAIN_SEARCH_LOCATOR}
    SeleniumLibrary.Input Text    locator=${MAIN_SEARCH_LOCATOR}
    ...                           text=${value}

Get Search Temperature
    [Documentation]    Get the search temperature result
    SeleniumLibrary.Wait Until Element Is Visible    locator=${TEMPERATURE_RESULT_LOCATOR}
    ${temperature}    SeleniumLibrary.Get Text    locator=${TEMPERATURE_RESULT_LOCATOR}
    ${parsedTemperature}    CustomString.Get Split String    ${temperature}    °    0    #WTF???
    [Return]    ${parsedTemperature}

