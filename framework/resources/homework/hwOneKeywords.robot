*** Settings ***
Resource    ../../../import.resource

*** Variables ***
@{HW_TIMESTAMP}

*** Keywords ***
Add Two Numbers
    [Arguments]    ${num1}
    ...            ${num2}
    ${sum}    BuiltIn.Evaluate    ${num1} + ${num2}
    BuiltIn.Set Test Variable    ${sum}

Sum Should Be Equal
    [Arguments]    ${val}
    ${val}    BuiltIn.Convert To Number    ${val}
    BuiltIn.Should Be Equal    ${sum}
    ...                        ${val}
    ...                        The result does not equal addition of variables

Get Current Time
    ${current}    CurrentTime.Get Now
    Collections.Append To List    ${HW_TIMESTAMP}
    ...                           ${current}

Difference Should Be Equal
    [Arguments]    ${val}
    ${val}    BuiltIn.Convert To Number    ${val}
    ${diff}    BuiltIn.Evaluate    ${HW_TIMESTAMP}[1] - ${HW_TIMESTAMP}[0]
    BuiltIn.Should Be Equal    ${diff}
    ...                        ${val}
    ...                        The result does not equal addition of variables
