*** Settings ***
Resource    ../../import.resource

*** Keywords ***
Open User Settings Page
    [Documentation]    User opens the User Settings page
    profilePage.Open User Settings Page
    profilePage.Verify User Settings Page Url

Verify User Settings Page Is Opened
    [Documentation]    The User Settings page is opened
    profilePage.Verify User Settings Page Url

Change User Name
    [Documentation]    User inputs a name and click Save button
    [Arguments]    ${name}
    profilePage.Input Username    ${name}
    profilePage.Click Save Button

