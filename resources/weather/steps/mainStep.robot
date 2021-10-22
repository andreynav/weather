*** Settings ***
Resource    ../../import.resource

*** Keywords ***
Go To Main Page
    [Documentation]    User opens the Main page
    mainPage.Go To Main Page
    mainStep.Verify Main Page Is Opened

Verify Main Page Is Opened
    [Documentation]    Verify the main page is opened by way checking unique element
    commonStep.Verify Unique Page Element    locator=${MAIN_ARTICLE1_TITLE_LOCATOR}
    ...                                      value=${MAIN_ARTICLE1_TITLE_VALUE}