*** Settings ***
Resource    ../../import.resource

*** Variables ***
@{listOfTemperature}

*** Keywords ***
Get Weather By Parameters And Verify Results
    [Documentation]    Get weather for a city via certain parameters
    [Arguments]    ${jsonPath}
    ...            ${expectedResult}
    ...            ${params}
    ${response}    GET    ${API_URL}
    ...                   ${params}
    RequestsLibrary.Status Should Be    ${CODE_SUCCESS}
    ${value}    Get Value From Json    ${response.json()}
    ...                                ${jsonPath}
    BuiltIn.Should Be Equal As Strings   ${value[0]}
    ...                                  ${expectedResult}

Get Weather By Parameters
    [Documentation]    Get weather for a city via certain parameters
    [Arguments]    ${jsonPath}
    ...            ${params}
    Get List Of Different Temperature Units Measurement Of The City    ${jsonPath}
    ...                                                                ${params}
    Verify The Returned Units Measurement Are True

Get List Of Different Temperature Units Measurement Of The City
    [Documentation]    Get different temperature measurement of the city and save it to list
    [Arguments]    ${jsonPath}
    ...            ${params}
    ${response}    GET    ${API_URL}
    ...                   ${params}
    RequestsLibrary.Status Should Be    ${CODE_SUCCESS}
    ${value}    Get Value From Json    ${response.json()}
    ...                                ${jsonPath}
    Collections.Append To List    ${listOfTemperature}
    ...                           ${value[0]}

Get Celsius From Kelvin
    [Documentation]    Get the celsius from kelvin via specific formula and return the result
    [Arguments]    ${kelvin}
    ${celsium}    BuiltIn.Evaluate    round(${kelvin} - 273.15, 2)
    [Return]    ${celsium}

Get Celsius From Fahrenheit
    [Documentation]    Get the celsius from fahrenheit via specific formula and return the result
    [Arguments]    ${fahrenheit}
    ${celsium}    BuiltIn.Evaluate    round(((${fahrenheit} - 32) * 5/9), 2)
    [Return]    ${celsium}

Verify The Returned Units Measurement Are True
    [Documentation]    Verify the returned temperature is the same for different units measurement
    BuiltIn.Log    ${listOfTemperature}
    ${listLength}    Get Length    ${listOfTemperature}
    IF    ${listLength} == 5    #!!!!magic number
        ${calculatedCelsiumFromKelvin}    Get Celsius From Kelvin    ${listOfTemperature[0]}
        ${calculatedCelsiumFromFahrenheit}    Get Celsius From Fahrenheit    ${listOfTemperature[2]}
        BuiltIn.Should Be Equal As Strings    ${calculatedCelsiumFromKelvin}
        ...                                   ${listOfTemperature[1]}
        BuiltIn.Should Be Equal As Strings    ${calculatedCelsiumFromFahrenheit}
        ...                                   ${listOfTemperature[1]}
    END

