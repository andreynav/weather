*** Settings ***
Resource                                    ../import.robot
Test Setup                                  common.Begin Test
Test Teardown                               common.End Test
Test Template                               Login With Invalid Credentials

*** Test Cases ***                          email                                   password
Invalid Email                               invalid                                 ${LOGIN_VALID_CREDENTIALS.password}
Invalid Password                            ${LOGIN_VALID_CREDENTIALS.email}        invalid
Invalid Both                                invalid                                 invalid
Empty Email                                 ${EMPTY}                                ${LOGIN_VALID_CREDENTIALS.password}
Empty Password                              ${LOGIN_VALID_CREDENTIALS.email}        ${EMPTY}
Empty Both                                  ${EMPTY}                                ${EMPTY}

*** Keywords ***
Login With Invalid Credentials
    [Documentation]                         User log in with invalid credentials
    [Arguments]                             ${email}                                ${password}
    loginPage.Login With Credentials        ${email}                                ${password}
    loginPage.Alert Should Be Appear