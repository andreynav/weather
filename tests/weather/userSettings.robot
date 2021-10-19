*** Settings ***
Resource          ../../import.resource
Suite Setup       commonStep.Open Browser And Maximaze
Suite Teardown    commonStep.Close Browser

*** Test Cases ***
Change User Name
    [Documentation]    User changes his name in user settings
    [Setup]    Run Keywords    loginStep.Open Sign In Page
    ...        AND             loginStep.Login With Credentials    ${USER_CREDENTIALS.email}
    ...                                                            ${USER_CREDENTIALS.password}
    ...        AND             profileStep.Open User Settings Page

    BuiltIn.Log Many    Step 1: Ввести имя пользователя в поле name
    ...                 ER 1: проверить сообщение о успешной смене имени
    profileStep.Change User Name    ${USER_NEXT_NAME}
    commonStep.Verify Alert Is Displayed    ${ALERT_PROFILE_UPDATED_VALUE}

    BuiltIn.Log Many    Step 2: перейти на главную страницу
    ...                 ER 2: новое имя пользователя отображается в навигационном меню
    mainStep.Open Main Page
    navbarStep.Verify User Signed In And His Name   ${USER_NEXT_NAME}

    [Teardown]    Run Keywords    commonStep.Delete Session
