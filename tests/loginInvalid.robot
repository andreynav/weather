*** Settings ***
Resource                    ../import.robot
Test Setup                  Begin Test
Test Teardown               End Test
Test Template               Login With Invalid Credentials

*** Test Cases ***          email                   password
Invalid Email               invalid                 ${validPassword}
Invalid Password            ${validEmail}           invalid
Invalid Both                invalid                 invalid
Empty Email                 ${EMPTY}                ${validPassword}
Empty Password              ${validEmail}           ${EMPTY}
Empty Both                  ${EMPTY}                ${EMPTY}

