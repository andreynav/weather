*** Settings ***
Resource            ../resources/userKeywords.robot

*** Test Cases ***
Sum of two variables
    Add Two Numbers  3  9
    Sum Should Be Equal  12

Get difference between two timestamp
    Get Current Time
    Waiting for seconds  2
    Get Current Time
    Difference Should Be Equal  2

