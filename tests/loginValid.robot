*** Settings ***
Resource                                                ../import.robot
Test Setup                                              main.Begin Test
Test Teardown                                           main.End Test

*** Test Cases ***
Login With Valid Credentials
    [Documentation]                                     User log in with valid credentials
    loginPage.Login With Credentials                    ${validCreds.email}    ${validCreds.password}
    loginPage.Succesful Notice Should Be Appear
