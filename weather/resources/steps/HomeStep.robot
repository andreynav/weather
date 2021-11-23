*** Settings ***
Resource    ../../../import.resource

*** Keywords ***
Go To Main Page
    [Documentation]    User opens the Home page
    HomePage.Go To Main Page
    HomeStep.Verify Main Page Is Opened

Verify Main Page Is Opened
    [Documentation]    Verify the Home page is opened by way checking unique element
    CommonStep.Verify Unique Page Element    locator=${HOME_ARTICLE1_TITLE_LOCATOR}
    ...                                      value=${HOME_ARTICLE1_TITLE_VALUE}
