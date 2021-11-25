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

    BuiltIn.Log Many    Step 1: Enter user name to field 'name'
    ...                 ER 1: Verify notification of successful name change
    ProfileStep.Change User Name    ${USER_NEXT_NAME}
    CommonStep.Verify Alert Is Displayed    ${ALERT_PROFILE_UPDATED_VALUE}

    BuiltIn.Log Many    Step 2: Go to home page
    ...                 ER 1: The user name is displayed at the navigation bar
    HomeStep.Go To Home Page
    NavbarStep.Verify User Name    ${USER_NEXT_NAME}

    [Teardown]    Run Keywords    ProfileStep.Open User Settings Page
    ...           AND             ProfileStep.Change User Name    ${USER_CURRENT_NAME}
