*** Settings ***
Resource                                                ../../import.robot
Suite Setup                                             common.Open Browser And Maximaze
Suite Teardown                                          common.Close Browser

*** Variables ***
&{USER_VALID_CREDENTIALS}                               email=nav.testsw@gmail.com          password=Qwerty123$
${USER_CURRENT_NAME}                                    andrei
${USER_NEXT_NAME}                                       andrei1

*** Test Cases ***
Login With Invalid CredentialS Should Fail
    [Documentation]                                     User log in with different cambinations of invalid credentials
    [Setup]                                             loginPage.Open Sign In Page
    [Teardown]                                          Run Keywords    Delete Session
    [Template]                                          Login With Invalid Credentials
    invalid                                             ${USER_VALID_CREDENTIALS.password}
    ${USER_VALID_CREDENTIALS.email}                     invalid
    invalid                                             invalid
    ${EMPTY}                                            ${USER_VALID_CREDENTIALS.password}
    ${USER_VALID_CREDENTIALS.email}                     ${EMPTY}
    ${EMPTY}                                            ${EMPTY}

Login With Valid And Invalid Credentials
    [Documentation]                                     User log in with valid and invalid credentials
    [Setup]                                             loginPage.Open Sign In Page
    [Teardown]                                          Run Keywords    Delete Session
    BuiltIn.Log Many                                    Step 1: Ввести правильный логин и неправильный пароль ->
    ...                                                 1) отображается  страница логина
    ...                                                 2) отображается ошибка о неправильных данных
    loginPage.Login With Credentials                    ${USER_VALID_CREDENTIALS.email}     invalid
    loginPage.Verify Sign In Page Is Opened
    loginPage.Verify Alert Is Appeared
    BuiltIn.Log Many                                    Step 2: ввести правильный пароль ->
    ...                                                 1) отображается главная страница  приложения
    ...                                                 2) пользователь авторизован в системе
    loginPage.Login With Credentials                    ${USER_VALID_CREDENTIALS.email}     ${USER_VALID_CREDENTIALS.password}
    mainPage.Verify Main Page Is Opened
    loginPage.Verify Successful Notice Is Appeared
    navbar.Verify User Signed In And His Name           ${USER_CURRENT_NAME}

*** Keywords ***
Login With Invalid Credentials
    [Documentation]                                     User log in with invalid credentials
    [Arguments]                                         ${email}                            ${password}
    loginPage.Login With Credentials                    ${email}                            ${password}
    loginPage.Verify Alert Is Appeared





