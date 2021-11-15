*** Settings ***
Resource    ../../../import.resource

*** Variables ***
${PROFILE_USER_SETTINGS_ITEM_MENU_LOCATOR}    //ul[contains(@class,"nav-pills")]//a[@href='/home']
${PROFILE_USER_SETTINGS_ITEM_MENU_VALUE}      User settings
${PROFILE_USERNAME_FIELD_LOCATOR}             //input[@id='profile_form_username']
${PROFILE_URL}                                https://home.openweathermap.org/home
${PROFILE_BUTTON_LOCATOR}                     //input[@value='Save']

*** Keywords ***
Open User Settings Page
    [Documentation]    User opens the User Settings page
    SeleniumLibrary.Go To   ${PROFILE_URL}

Input Username
    [Documentation]    User inputs a name
    [Arguments]    ${name}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${PROFILE_USERNAME_FIELD_LOCATOR}
    SeleniumLibrary.Input Text    locator=${PROFILE_USERNAME_FIELD_LOCATOR}
    ...                           text=${name}
    ...                           clear=true

Click Save Button
    [Documentation]    User clicks the button Submit
    SeleniumLibrary.Wait Until Element Is Visible    locator=${PROFILE_BUTTON_LOCATOR}
    SeleniumLibrary.Click Element    locator=${PROFILE_BUTTON_LOCATOR}
