*** Settings ***
Resource    ../../import.resource

*** Keywords ***
Go To Main Page
    [Documentation]    User opens the Main page
    mainPage.Go To Main Page
    mainPage.Verify Main Page Url

Verify Main Page Is Opened
    [Documentation]    Verify the Main page is opened
    mainPage.Verify Main Page Url
