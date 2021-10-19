*** Settings ***
Resource    ../../import.resource

*** Keywords ***
Open Main Page
    [Documentation]    User opens the Main page
    mainPage.Open Main Page
    mainPage.Verify Main Page Url

Verify Main Page Is Opened
    [Documentation]    Verify the Main page is opened
    mainPage.Verify Main Page Url
