*** Settings ***
Resource    ../../../../import.resource

*** Keywords ***
Get Weather By Parameters And Verify Results
    [Documentation]    Get weather for a city via certain parameters
    [Arguments]    ${jsonPath}
    ...            ${expectedResult}
    ...            ${params}
    ${value}    api.Get Value For Specific JPath    ${jsonPath}
    ...                                             ${params}
    BuiltIn.Should Be Equal As Strings   ${value}
    ...                                  ${expectedResult}

Get City Temperature Via Units And Verify Measure
    [Documentation]
    [Arguments]    ${jsonPath}
    ...            ${q}
    ...            ${appid}
    ...            ${units}
    BuiltIn.Log Many    Step 1: получить данные о погоде для города ${q} с использованием параметра ${units}
    ...                 ER 1: температура выводится в ${units}
    ${params1}    api.Create Valid Dictionary Of Params    q=${q}
    ...                                                    appid=${appid}
    ...                                                    units=${units}
    ${temp1}    api.Get Value For Specific JPath    ${jsonPath}
    ...                                             ${params1}
    ${measureTemp2}    api.Get Random Measure Except    ${params1.units}
    ${params2}    api.Create Valid Dictionary Of Params    q=${q}
    ...                                                    appid=${appid}
    ...                                                    units=${measureTemp2}
    ${temp2}    api.Get Value For Specific JPath    ${jsonPath}
    ...                                             ${params2}
    ${convertedTemp2ToTemp1}    api.Converting Measure Temp1 To Measure Temp2    ${temp2}
    ...                                                                          ${measureTemp2}
    ...                                                                          ${params1.units}
    BuiltIn.Should Be Equal As Strings    ${temp1}
    ...                                   ${convertedTemp2ToTemp1}

Converting Measure Temp1 To Measure Temp2
    [Documentation]    Get three params: temperature, current temperature measure, and expected temperature measure,\n
    ...                then convert the first one to another and return the result
    [Arguments]    ${temperature}
    ...            ${currentMeasure}
    ...            ${expectedMeasure}
    IF    "${currentMeasure}" == "standard"
        IF    "${expectedMeasure}" == "metric"
            ${convertedValue}    BuiltIn.Evaluate    round( ${temperature} - 273.15, 2)
        ELSE
            #${expectedMeasure} == "imperial"
            ${convertedValue}    BuiltIn.Evaluate    round( ((${temperature} - 273.15) * 9/5 + 32), 2)
        END
    ELSE IF    "${currentMeasure}" == "metric"
        IF    "${expectedMeasure}" == "standard"
            ${convertedValue}    BuiltIn.Evaluate    round( ${temperature} + 273.15, 2)
        ELSE
            #${expectedMeasure} == "imperial"
            ${convertedValue}    BuiltIn.Evaluate    round( (${temperature} * 9/5) + 32, 2)
        END
    ELSE    #${currentMeasure} == "imperial"
         IF    "${expectedMeasure}" == "standard"
            ${convertedValue}    BuiltIn.Evaluate    round( ((${temperature} - 32) * 5/9) + 273.15, 2)
        ELSE
            #${expectedMeasure} == "metric"
            ${convertedValue}    BuiltIn.Evaluate    round( ((${temperature} - 32) * 5/9), 2)
        END
    END
    [Return]    ${convertedValue}

Get Random Measure Except
    [Documentation]
    [Arguments]    ${existingMeasure}
    ${unitKeys}    Collections.Get Dictionary Keys    ${UNITS}
    ${randomMeausure}    randomList.Get Random Item Except Current From List    ${existingMeasure}
    ...                                                                         ${unitKeys}
    [Return]    ${randomMeausure}

Get Value For Specific JPath
    [Documentation]    Get weather for a city via certain parameters
    [Arguments]    ${jsonPath}
    ...            ${params}
    ${response}    RequestsLibrary.GET    ${API_URL}
    ...                                   ${params}
    RequestsLibrary.Status Should Be    ${CODE_SUCCESS}
    ${temperature}    JSONLibrary.Get Value From Json    ${response.json()}
    ...                                                  ${jsonPath}
    [Return]    ${temperature[0]}

Create Valid Dictionary Of Params
    [Documentation]
    [Arguments]    ${q}
    ...            ${appid}
    ...            ${units}
    ${params}    BuiltIn.Create Dictionary    q=${q}
    ...                                       appid=${appid}
    ...                                       units=${units}
    ${paramUpdated}    randomList.Default Param    ${params}
    [Return]    ${paramUpdated}