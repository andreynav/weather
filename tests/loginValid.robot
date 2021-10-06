*** Settings ***
Resource                                    ../import.robot
Test Setup                                  Begin Test
Test Teardown                               End Test

*** Test Cases ***
Login With Valid Credentials
    [Documentation]                         User log in with valid credentials
    Login With Credentials                  ${validEmail}    ${validPassword}
    Succesful Notice Should Be Appear
