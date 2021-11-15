*** Settings ***
Resource    ../../import.resource

*** Test Cases ***
Sum of two variables
    hwOneKeywords.Add Two Numbers    3    9
    hwOneKeywords.Sum Should Be Equal    12

Get difference between two timestamps
    hwOneKeywords.Get Current Time
    BuiltIn.Sleep    2
    hwOneKeywords.Get Current Time
    hwOneKeywords.Difference Should Be Equal    2
