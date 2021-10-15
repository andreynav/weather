*** Settings ***
Resource                                                ../../import.robot
Suite Setup                                             common.Open Browser And Maximaze
Suite Teardown                                          common.Close Browser

*** Test Cases ***
Login With Invalid Credentials Should Fail
    [Documentation]                                     User log in with different cambinations of invalid credentials
    [Setup]                                             loginPage.Open Sign In Page
    [Template]                                          Login With Invalid Credentials
    invalid                                             ${USER_CREDENTIALS.password}
    ${USER_CREDENTIALS.email}                           invalid
    invalid                                             invalid
    ${EMPTY}                                            ${USER_CREDENTIALS.password}
    ${USER_CREDENTIALS.email}                           ${EMPTY}
    ${EMPTY}                                            ${EMPTY}
    [Teardown]                                          Run Keywords    Delete Session

Login With Valid And Invalid Credentials
    [Documentation]                                     User log in with valid and invalid credentials
    [Setup]                                             loginPage.Open Sign In Page
    BuiltIn.Log Many                                    Step 1: Ввести правильный логин и неправильный пароль
    ...                                                 ER 1: отображается  страница логина
    ...                                                 ER 2: отображается ошибка о неправильных данных
    loginPage.Login With Credentials                    ${USER_CREDENTIALS.email}       invalid
    loginPage.Verify Sign In Page Is Opened
    common.Verify Alert Is Displayed                    ${ALERT_INVALID_CREDS_VALUE}
    BuiltIn.Log Many                                    Step 2: ввести правильный пароль
    ...                                                 ER 1: отображается главная страница  приложения
    ...                                                 ER 2: пользователь авторизован в системе
    loginPage.Login With Credentials                    ${USER_CREDENTIALS.email}       ${USER_CREDENTIALS.password}
    mainPage.Verify Main Page Is Opened
    common.Verify Alert Is Displayed                    ${ALERT_SIGNEDIN_VALUE}
    navbar.Verify User Signed In And His Name           ${USER_CURRENT_NAME}
    [Teardown]                                          Run Keywords    Delete Session

*** Keywords ***
Login With Invalid Credentials
    [Documentation]                                     User log in with invalid credentials
    [Arguments]                                         ${email}                        ${password}
    loginPage.Login With Credentials                    ${email}                        ${password}
    common.Verify Alert Is Displayed                    ${ALERT_INVALID_CREDS_VALUE}
    loginPage.Verify Sign In Page Is Opened





