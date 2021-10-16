*** Settings ***
Resource    ../../import.robot

*** Keywords ***
Login With Credentials
	[Documentation]    User log in with credentials
	[Arguments]    ${email}
	...            ${password}
	loginPage.Input Email    ${email}
	loginPage.Input Password    ${password}
	loginPage.Submit Credentials

Open Sign In Page
	[Documentation]    User opens the Sign In page
	loginPage.Open Sign In Page
	loginPage.Verify Sign In Page Url

Verify Sign In Page Is Opened
    [Documentation]     Verify the Sign In page is opend
	loginPage.Verify Sign In Page Url


