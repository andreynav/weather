*** Settings ***
Resource                    ../import.robot
Test Setup                  main.Begin Test
Test Teardown               main.End Test
Test Template               loginPage.Login With Invalid Credentials

*** Test Cases ***          email                   password
Invalid Email               invalid                 ${validCreds.password}
Invalid Password            ${validCreds.email}     invalid
Invalid Both                invalid                 invalid
Empty Email                 ${EMPTY}                ${validCreds.password}
Empty Password              ${validCreds.email}     ${EMPTY}
Empty Both                  ${EMPTY}                ${EMPTY}

