*** Settings ***
Resource    ../../../import.resource

*** Keywords ***
Go To Home Page
    [Documentation]    User opens the Home page
    HomePage.Go To Home Page
    HomeStep.Verify Home Page Is Opened

Verify Home Page Is Opened
    [Documentation]    Verify the Home page is opened by way checking unique element
    CommonStep.Verify Unique Page Element    locator=${HOME_ARTICLE1_TITLE_LOCATOR}
    ...                                      value=${HOME_ARTICLE1_TITLE_VALUE}
