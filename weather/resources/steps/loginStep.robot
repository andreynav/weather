*** Settings ***
Resource    ../../../import.resource

*** Keywords ***
Login With Credentials
	[Documentation]    User log in with credentials
	[Arguments]    ${email}
	...            ${password}
	loginPage.Input Email    ${email}
	loginPage.Input Password    ${password}
	loginPage.Submit Credentials

Go To Sign In Page
	[Documentation]    User opens the Sign In page
	loginPage.Go To Sign In Page
	loginStep.Verify Sign In Page Is Opened

Verify Sign In Page Is Opened
    [Documentation]     Verify the Sign In page is opened by way checking unique element
    commonStep.Verify Unique Page Element    locator=${LOGIN_MODAL_TITLE_LOCATOR}
    ...                                      value=${LOGIN_MODAL_TITLE_VALUE}