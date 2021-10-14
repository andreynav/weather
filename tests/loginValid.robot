*** Settings ***
Resource                                                ../import.robot
Test Setup                                              common.Begin Test
Test Teardown                                           common.End Test

*** Test Cases ***
Login With Valid Credentials
    [Documentation]                                     User log in with valid credentials
    loginPage.Login With Credentials                    ${LOGIN_VALID_CREDENTIALS.email}    ${LOGIN_VALID_CREDENTIALS.password}
    loginPage.Succesful Notice Should Be Appear
