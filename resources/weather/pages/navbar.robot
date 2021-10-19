*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${NAVBAR_SIGNIN_ITEM_LOCATOR}         //li[contains(@class,"user-li")]/a
${NAVBAR_SIGNED_USER_ITEM_LOCATOR}    //div[@class='inner-user-container']

*** Keywords ***
Verify User Signed In And His Name
    [Documentation]    User signed in and his name is displayed in navbar
    [Arguments]    ${name}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${NAVBAR_SIGNED_USER_ITEM_LOCATOR}
    SeleniumLibrary.Wait Until Element Contains    locator=${NAVBAR_SIGNED_USER_ITEM_LOCATOR}
    ...                                            text=${name}
