*** Settings ***
Resource    ../../import.resource

*** Test Cases ***
Sum of two variables
    HwOneKeywords.Add Two Numbers    3    9
    HwOneKeywords.Sum Should Be Equal    12

Get difference between two timestamps
    HwOneKeywords.Get Current Time
    BuiltIn.Sleep    2
    HwOneKeywords.Get Current Time
    HwOneKeywords.Difference Should Be Equal    2
