*** Settings ***
Resource                                                ../../import.robot
Suite Setup                                             common.Open Browser And Maximaze
Suite Teardown                                          common.Close Browser

*** Variables ***
&{USER_VALID_CREDENTIALS}                               email=nav.testsw@gmail.com          password=Qwerty123$
${USER_CURRENT_NAME}                                    andrei
${USER_NEXT_NAME}                                       andrei1

*** Test Cases ***
Change User Name
    [Documentation]                                     User changes his name in user settings
    [Setup]                                             Run Keywords  loginPage.Open Sign In Page
    ...                AND                              loginPage.Login With Credentials    ${USER_VALID_CREDENTIALS.email}    ${USER_VALID_CREDENTIALS.password}
    ...                AND                              userSettingsPage.Open User Settings Page
    [Teardown]                                          Run Keywords    Delete Session
    BuiltIn.Log Many                                    Ввести имя пользователя в поле name ->
    ...                                                 1) проверить сообщение о успешной смене имени
    userSettingsPage.Input Username                     ${USER_NEXT_NAME}
    userSettingsPage.Click Save Button
    userSettingsPage.Verify Successful Notice Is Appeared
    BuiltIn.Log Many                                    перейти на главную страницу ->
    ...                                                 новое имя пользователя отображается в навигационном меню
    mainPAge.Open Main Page
    navbar.Verify User Signed In And His Name           ${USER_NEXT_NAME}
