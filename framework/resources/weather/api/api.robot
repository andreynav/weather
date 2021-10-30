*** Settings ***
#Resource    ../../import.resource
Resource    ../../../../import.resource

*** Variables ***
@{listOfTemperature}
${CELSIUS}    'CELSIUS'
${KELVIN}    'KELVIN'
${FAHRENHEIT}    'FAHRENHEIT'

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

Converting Temperature To Another Measure
    [Documentation]    Get three params: temperature, current temperature measure, and expected temperature measure,\n
    ...                then convert the first one to another and return the result
    [Arguments]    ${temperature}
    ...            ${currentMeasure}
    ...            ${expectedMeasure}
    IF    ${currentMeasure} == ${KELVIN}
        IF    ${expectedMeasure} == ${CELSIUS}
            ${convertedValue}    BuiltIn.Evaluate    round( ${temperature} - 273.15, 2)
        ELSE
            #${expectedMeasure} == ${FAHRENHEIT}
            ${convertedValue}    BuiltIn.Evaluate    round( ((${temperature} - 273.15) * 9/5 + 32), 2)
        END
    ELSE IF    ${currentMeasure} == ${CELSIUS}
        IF    ${expectedMeasure} == ${KELVIN}
            ${convertedValue}    BuiltIn.Evaluate    round( ${temperature} + 273.15, 2)
        ELSE
            #${expectedMeasure} == ${FAHRENHEIT}
            ${convertedValue}    BuiltIn.Evaluate    round( (${temperature} * 9/5) + 32, 2)
        END
    ELSE    #${currentMeasure} == ${FAHRENHEIT}
         IF    ${expectedMeasure} == ${KELVIN}
            ${convertedValue}    BuiltIn.Evaluate    round( ((${temperature} - 32) * 5/9) + 273.15, 2)
        ELSE
            #${expectedMeasure} == ${CELSIUS}
            ${convertedValue}    BuiltIn.Evaluate    round( ((${temperature} - 32) * 5/9), 2)
        END
    END
    [Return]    ${convertedValue}

Verify The Returned Units Measurement Are True
    [Documentation]    Verify the returned temperature is the same for different units measurement
    BuiltIn.Log    ${listOfTemperature}
    ${listLength}    Get Length    ${listOfTemperature}
    IF    ${listLength} == 5    #!!!!magic number
        BuiltIn.Log    ${BELMOPAN_ID}
        BuiltIn.Log    ${JSON_PATH}
        ${calculatedCelsiusFromKelvin}    Converting Temperature To Another Measure    ${listOfTemperature[0]}
        ...                                                                            ${KELVIN}
        ...                                                                            ${CELSIUS}
        ${calculatedCelsiusFromFahrenheit}    Converting Temperature To Another Measure    ${listOfTemperature[2]}
        ...                                                                                ${FAHRENHEIT}
        ...                                                                                ${CELSIUS}
        BuiltIn.Should Be Equal As Strings    ${calculatedCelsiusFromKelvin}
        ...                                   ${listOfTemperature[1]}
        BuiltIn.Should Be Equal As Strings    ${calculatedCelsiusFromFahrenheit}
        ...                                   ${listOfTemperature[1]}
    END

