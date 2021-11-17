*** Settings ***
Resource          ../../import.resource
Suite Setup       CommonStep.Open Browser And Maximaze
Suite Teardown    CommonStep.Close Browser

*** Test Cases ***
Change User Name
    [Documentation]    User changes his name in user settings
    [Setup]    Run Keywords    LoginStep.Go To Sign In Page
    ...        AND             LoginStep.Login With Credentials    ${USER_CREDENTIALS.email}
    ...                                                            ${USER_CREDENTIALS.password}
    ...        AND             ProfileStep.Open User Settings Page

    BuiltIn.Log Many    Step 1: Ввести имя пользователя в поле name
    ...                 ER 1: проверить сообщение о успешной смене имени
    ProfileStep.Change User Name    ${USER_NEXT_NAME}
    CommonStep.Verify Alert Is Displayed    ${ALERT_PROFILE_UPDATED_VALUE}

    BuiltIn.Log Many    Step 2: перейти на главную страницу
    ...                 ER 2: новое имя пользователя отображается в навигационном меню
    HomeStep.Go To Main Page
    NavbarStep.Verify User Name    ${USER_NEXT_NAME}

    [Teardown]    Run Keywords    ProfileStep.Open User Settings Page
    ...           AND             ProfileStep.Change User Name    ${USER_CURRENT_NAME}
