*** Settings ***
Resource                                    ../import.robot
Test Setup                                  Begin Test
Test Teardown                               End Test

*** Test Cases ***
Login With Valid Credentials Should Pass
    Go to Sign In Page
    Input Email                             ${validEmail}
    Input Password                          ${validPassword}
    Submit Credentials
    Succesful Notice Should Be Appear
