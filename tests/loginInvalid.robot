*** Settings ***
Resource                    ../import.robot
Test Setup                  main.Begin Test
Test Teardown               main.End Test
Test Template               loginPage.Login With Invalid Credentials

*** Test Cases ***          email                   password
Invalid Email               invalid                 ${validPassword}
Invalid Password            ${validEmail}           invalid
Invalid Both                invalid                 invalid
Empty Email                 ${EMPTY}                ${validPassword}
Empty Password              ${validEmail}           ${EMPTY}
Empty Both                  ${EMPTY}                ${EMPTY}

