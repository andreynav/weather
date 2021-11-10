*** Settings ***
Resource    ../../import.resource

*** Variables ***
${NAVBAR_SIGNIN_ITEM_LOCATOR}         //li[contains(@class,"user-li")]/a
${NAVBAR_SIGNED_USER_ITEM_LOCATOR}    //div[@class='inner-user-container']

*** Keywords ***
Get User Name
    [Documentation]    Get user name which is displayed in navbar
    SeleniumLibrary.Wait Until Element Is Visible    locator=${NAVBAR_SIGNED_USER_ITEM_LOCATOR}
    ${userName}    SeleniumLibrary.Get Text    locator=${NAVBAR_SIGNED_USER_ITEM_LOCATOR}
    [Return]    ${userName}