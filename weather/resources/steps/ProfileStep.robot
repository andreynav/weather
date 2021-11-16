*** Settings ***
Resource    ../../../import.resource

*** Keywords ***
Open User Settings Page
    [Documentation]    User opens the User Settings page
    ProfilePage.Open User Settings Page
    ProfileStep.Verify User Settings Page Is Opened

Verify User Settings Page Is Opened
    [Documentation]    Verify the user settings page is opened by way checking unique element
    CommonStep.Verify Unique Page Element    locator=${PROFILE_USER_SETTINGS_ITEM_MENU_LOCATOR}
    ...                                      value=${PROFILE_USER_SETTINGS_ITEM_MENU_VALUE}

Change User Name
    [Documentation]    User inputs a name and click Save button
    [Arguments]    ${name}
    ProfilePage.Input Username    ${name}
    ProfilePage.Click Save Button

