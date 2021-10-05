*** Settings ***
Resource                        ../import.robot

*** Variables ***
${counter}                      ${0}
${timestamp1}                   null
${timestamp2}                   null

*** Keywords ***
Add Two Numbers
    [Arguments]                 ${num1}     ${num2}
    ${sum}=  Evaluate           ${num1} + ${num2}
    Set Test Variable           ${sum}

Sum Should Be Equal
    [Arguments]                 ${val}
    ${val}=  Convert To Number  ${val}
    Should Be Equal             ${sum}  ${val}  The result does not equal addition of variables

Get Current Time
    IF  ${counter} == 0
        ${timestamp1}           currentTime.getnow
        Set Test Variable       ${timestamp1}
        ${counter}  Evaluate    int("${counter}") + 1
        Set Test Variable       ${counter}
    ELSE
        ${timestamp2}           currentTime.getnow
        Set Test Variable       ${timestamp2}
    END

Waiting for seconds
    [Arguments]                 ${sec}
    Sleep                       ${sec}

Difference Should Be Equal
    [Arguments]                 ${val}
    ${val}  Convert To Number   ${val}
    ${diff}  Evaluate           ${timestamp2} - ${timestamp1}
    Should Be Equal             ${diff}  ${val}  The result does not equal addition of variables
