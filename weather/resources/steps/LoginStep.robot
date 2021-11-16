*** Settings ***
Resource    ../../../import.resource

*** Keywords ***
Login With Credentials
	[Documentation]    User log in with credentials
	[Arguments]    ${email}
	...            ${password}
	LoginPage.Input Email    ${email}
	LoginPage.Input Password    ${password}
	LoginPage.Submit Credentials

Go To Sign In Page
	[Documentation]    User opens the Sign In page
	LoginPage.Go To Sign In Page
	LoginStep.Verify Sign In Page Is Opened

Verify Sign In Page Is Opened
    [Documentation]     Verify the Sign In page is opened by way checking unique element
    CommonStep.Verify Unique Page Element    locator=${LOGIN_MODAL_TITLE_LOCATOR}
    ...                                      value=${LOGIN_MODAL_TITLE_VALUE}