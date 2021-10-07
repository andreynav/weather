*** Settings ***
Resource                                    ../import.robot

*** Variables ***
${counter}                                  ${0}
${timestamp1}                               null
${timestamp2}                               null

*** Keywords ***
Add Two Numbers
    [Arguments]                             ${num1}     ${num2}
    ${sum}      BuiltIn.Evaluate            ${num1} + ${num2}
    BuiltIn.Set Test Variable               ${sum}

Sum Should Be Equal
    [Arguments]                             ${val}
    ${val}      BuiltIn.Convert To Number   ${val}
    BuiltIn.Should Be Equal                 ${sum}      ${val}      The result does not equal addition of variables

Get Current Time
    IF  ${counter} == 0
        ${timestamp1}                       currentTime.getnow
        BuiltIn.Set Test Variable           ${timestamp1}
        ${counter}      BuiltIn.Evaluate    int("${counter}") + 1
        BuiltIn.Set Test Variable           ${counter}
    ELSE
        ${timestamp2}                       currentTime.getnow
        BuiltIn.Set Test Variable           ${timestamp2}
    END

Waiting for seconds
    [Arguments]                             ${sec}
    BuiltIn.Sleep                           ${sec}

Difference Should Be Equal
    [Arguments]                             ${val}
    ${val}      BuiltIn.Convert To Number   ${val}
    ${diff}     BuiltIn.Evaluate            ${timestamp2} - ${timestamp1}
    BuiltIn.Should Be Equal                 ${diff}     ${val}     The result does not equal addition of variables
