*** Settings ***
Resource                                                ../../import.robot
Suite Setup                                             common.Open Browser And Maximaze
Suite Teardown                                          common.Close Browser

*** Test Cases ***
Change User Name
    [Documentation]                                     User changes his name in user settings
    [Setup]                                             Run Keywords  loginPage.Open Sign In Page
    ...                AND                              loginPage.Login With Credentials    ${USER_CREDENTIALS.email}    ${USER_CREDENTIALS.password}
    ...                AND                              PROFILEPage.Open User Settings Page
    [Teardown]                                          Run Keywords    Delete Session
    BuiltIn.Log Many                                    Step 1: Ввести имя пользователя в поле name
    ...                                                 ER 1: проверить сообщение о успешной смене имени
    profilePage.Input Username                          ${USER_NEXT_NAME}
    profilePage.Click Save Button
    common.Verify Alert Is Displayed                    ${ALERT_PROFILE_UPDATED_VALUE}
    BuiltIn.Log Many                                    Step 1: перейти на главную страницу
    ...                                                 ER 1: новое имя пользователя отображается в навигационном меню
    mainPage.Open Main Page
    navbar.Verify User Signed In And His Name           ${USER_NEXT_NAME}
