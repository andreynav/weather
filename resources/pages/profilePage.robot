*** Settings ***
Library                                                 SeleniumLibrary

*** Variables ***
${PROFILE_USER_SETTINGS_ITEM_MENU_LOCATOR}              //ul[contains(@class,"nav-pills")]//a[@href='/home']
${PROFILE_USER_SETTINGS_ITEM_MENU_VALUE}                User settings
${PROFILE_USERNAME_FIELD_LOCATOR}                       //input[@id='profile_form_username']
${PROFILE_URL}                                          https://home.openweathermap.org/home
${PROFILE_BUTTON_LOCATOR}                               //input[@value='Save']
${PROFILE_ALERT_SUCCESS_TITLE_LOCATOR}                  //div[@class='panel-heading']
${PROFILE_ALERT_SUCCESS_TEXT_LOCATOR}                   //div[@class='panel-heading']/following-sibling::div
${PROFILE_ALERT_SUCCESS_TEXT_VALUE}                     Profile was updated successfully

*** Keywords ***
Open User Settings Page
    [Documentation]                                     User opens the User Settings page
    SeleniumLibrary.Go To                               ${PROFILE_URL}
    SeleniumLibrary.Wait Until Element Contains         locator=${PROFILE_USER_SETTINGS_ITEM_MENU_LOCATOR}     text=${PROFILE_USER_SETTINGS_ITEM_MENU_VALUE}

Verify User Settings Page Is Opened
    [Documentation]                                     The user settings page is opened
    SeleniumLibrary.Wait Until Location Is              ${PROFILE_URL}

Input Username
    [Documentation]                                     User input a name  #сделать проверку на существующее имя
    [Arguments]                                         ${name}
    SeleniumLibrary.Wait Until Element Is Visible       locator=${PROFILE_USERNAME_FIELD_LOCATOR}
    SeleniumLibrary.Input Text                          locator=${PROFILE_USERNAME_FIELD_LOCATOR}            text=${name}     clear=true

Click Save Button
    [Documentation]                                     User clicks the button Submit
    SeleniumLibrary.Click Element                       locator=${PROFILE_BUTTON_LOCATOR}

Verify Successful Notice Is Appeared
    [Documentation]                                     The notification that the user changed his name successfully is displayed
    SeleniumLibrary.Wait Until Element Is Visible       locator=${PROFILE_ALERT_SUCCESS_TITLE_LOCATOR}
    SeleniumLibrary.Wait Until Element Contains         locator=${PROFILE_ALERT_SUCCESS_TEXT_LOCATOR}     text=${PROFILE_ALERT_SUCCESS_TEXT_VALUE}