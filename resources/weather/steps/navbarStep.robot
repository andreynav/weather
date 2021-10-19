*** Settings ***
Resource    ../../import.resource

*** Keywords ***
Verify User Signed In And His Name
    [Documentation]    User signed in and his name is displayed in navbar
    [Arguments]    ${name}
    navbar.Verify User Signed In And His Name    ${name}
