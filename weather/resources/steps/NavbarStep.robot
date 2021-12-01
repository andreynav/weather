*** Settings ***
Resource    ../../../import.resource

*** Keywords ***
Verify User Name
    [Documentation]    Verify the user ${name} is displayed in navbar
    [Arguments]    ${name}
    ${userName}    Navbar.Get User Name
    BuiltIn.Should Be Equal    ${userName}
    ...                        ${name}
    ...                        The name does not equal exisitng

User Logout Site
     [Documentation]    User log out the site
     Navbar.Click Logout Item
     LoginStep.Verify Sign In Page Is Opened    #


