*** Settings ***
Resource                                        ../import.robot

*** Variables ***
${HW_COUNTER}                                   ${0}
${HW_TIMESTAMP1}                                null
${HW_TIMESTAMP2}                                null

*** Keywords ***
Add Two Numbers
    [Arguments]                                 ${num1}     ${num2}
    ${sum}      BuiltIn.Evaluate                ${num1} + ${num2}
    BuiltIn.Set Test Variable                   ${sum}

Sum Should Be Equal
    [Arguments]                                 ${val}
    ${val}      BuiltIn.Convert To Number       ${val}
    BuiltIn.Should Be Equal                     ${sum}      ${val}      The result does not equal addition of variables

Get Current Time
    IF  ${HW_COUNTER} == 0
        ${HW_TIMESTAMP1}                        currentTime.getnow
        BuiltIn.Set Test Variable               ${HW_TIMESTAMP1}
        ${HW_COUNTER}      BuiltIn.Evaluate     int("${HW_COUNTER}") + 1
        BuiltIn.Set Test Variable               ${HW_COUNTER}
    ELSE
        ${HW_TIMESTAMP2}                        currentTime.getnow
        BuiltIn.Set Test Variable               ${HW_TIMESTAMP2}
    END

Waiting for seconds
    [Arguments]                                 ${sec}
    BuiltIn.Sleep                               ${sec}

Difference Should Be Equal
    [Arguments]                                 ${val}
    ${val}      BuiltIn.Convert To Number       ${val}
    ${diff}     BuiltIn.Evaluate                ${HW_TIMESTAMP2} - ${HW_TIMESTAMP1}
    BuiltIn.Should Be Equal                     ${diff}     ${val}     The result does not equal addition of variables
