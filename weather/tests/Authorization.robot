*** Settings ***
Resource          ../../import.resource
Suite Setup       CommonStep.Open Browser And Maximaze
Suite Teardown    CommonStep.Close Browser

*** Test Cases ***
Login With Invalid Credentials Should Fail
    [Documentation]    User log in with different cambinations of invalid credentials
    [Setup]    LoginStep.Go To Sign In Page

    [Template]    Login With Invalid Credentials
    invalid    ${USER_CREDENTIALS.password}
    ${USER_CREDENTIALS.email}   invalid
    invalid    invalid
    ${EMPTY}    ${USER_CREDENTIALS.password}
    ${USER_CREDENTIALS.email}   ${EMPTY}
    ${EMPTY}    ${EMPTY}

    [Teardown]    CommonStep.Delete Session

Login With Valid And Invalid Credentials
    [Documentation]    User log in with valid and invalid credentials
    [Setup]    LoginStep.Go To Sign In Page

    BuiltIn.Log Many    Step 1: Ввести правильный логин и неправильный пароль
    ...                 ER 1: отображается  страница логина
    ...                 ER 2: отображается ошибка о неправильных данных
    LoginStep.Login With Credentials    ${USER_CREDENTIALS.email}
    ...                                 invalid
    LoginStep.Verify Sign In Page Is Opened
    CommonStep.Verify Alert Is Displayed    ${ALERT_INVALID_CREDS_VALUE}

    BuiltIn.Log Many    Step 2: ввести правильный пароль
    ...                 ER 1: отображается главная страница  приложения
    ...                 ER 2: пользователь авторизован в системе
    LoginStep.Login With Credentials    ${USER_CREDENTIALS.email}
    ...                                 ${USER_CREDENTIALS.password}
    HomeStep.Verify Main Page Is Opened
    CommonStep.Verify Alert Is Displayed    ${ALERT_SIGNEDIN_VALUE}
    NavbarStep.Verify User Name    ${USER_CURRENT_NAME}

    [Teardown]    CommonStep.Delete Session

*** Keywords ***
Login With Invalid Credentials
    [Documentation]    User log in with invalid credentials
    [Arguments]    ${email}
    ...            ${password}
    LoginStep.Login With Credentials    ${email}
    ...                                 ${password}
    CommonStep.Verify Alert Is Displayed    ${ALERT_INVALID_CREDS_VALUE}
    LoginStep.Verify Sign In Page Is Opened
