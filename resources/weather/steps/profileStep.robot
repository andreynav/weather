*** Settings ***
Resource    ../../import.resource

*** Keywords ***
Open User Settings Page
    [Documentation]    User opens the User Settings page
    profilePage.Open User Settings Page
    profileStep.Verify User Settings Page Is Opened

Verify User Settings Page Is Opened
    [Documentation]    Verify the user settings page is opened by way checking unique element
    commonStep.Verify Unique Page Element    locator=${PROFILE_USER_SETTINGS_ITEM_MENU_LOCATOR}
    ...                                      value=${PROFILE_USER_SETTINGS_ITEM_MENU_VALUE}

Change User Name
    [Documentation]    User inputs a name and click Save button
    [Arguments]    ${name}
    profilePage.Input Username    ${name}
    profilePage.Click Save Button

