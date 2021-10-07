*** Settings ***
Resource                    ../import.robot
Test Setup                  main.Begin Test
Test Teardown               main.End Test
Test Template               loginPage.Login With Invalid Credentials

*** Test Cases ***          email                               password
Invalid Email               invalid                             ${LOGIN_VALID_CREDENTIALS.password}
Invalid Password            ${LOGIN_VALID_CREDENTIALS.email}    invalid
Invalid Both                invalid                             invalid
Empty Email                 ${EMPTY}                            ${LOGIN_VALID_CREDENTIALS.password}
Empty Password              ${LOGIN_VALID_CREDENTIALS.email}    ${EMPTY}
Empty Both                  ${EMPTY}                            ${EMPTY}

