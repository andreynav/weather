*** Settings ***
Resource    ../../../../import.resource

*** Keywords ***
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
            BuiltIn.Log    expectedMeasure == imperial
            ${convertedValue}    BuiltIn.Evaluate    round( ((${temperature} - 273.15) * 9/5 + 32), 2)
        END
    ELSE IF    "${currentMeasure}" == "metric"
        IF    "${expectedMeasure}" == "standard"
            ${convertedValue}    BuiltIn.Evaluate    round( ${temperature} + 273.15, 2)
        ELSE
            BuiltIn.Log    expectedMeasure == imperial
            ${convertedValue}    BuiltIn.Evaluate    round( (${temperature} * 9/5) + 32, 2)
        END
    ELSE
         BuiltIn.Log    currentMeasure == imperial
         IF    "${expectedMeasure}" == "standard"
            ${convertedValue}    BuiltIn.Evaluate    round( ((${temperature} - 32) * 5/9) + 273.15, 2)
        ELSE
            BuiltIn.Log    expectedMeasure == metric
            ${convertedValue}    BuiltIn.Evaluate    round( ((${temperature} - 32) * 5/9), 2)
        END
    END
    [Return]    ${convertedValue}

Get Random Measure Except
    [Documentation]    Get random temperature measure except getting as parameter
    [Arguments]    ${existingMeasure}
    ${unitKeys}    Collections.Get Dictionary Keys    ${UNITS}
    ${randomMeausure}    random_list.Get Random Item Except Current From List    ${existingMeasure}
    ...                                                                         ${unitKeys}
    [Return]    ${randomMeausure}

Get Value For Specific JPath
    [Documentation]    Get value of specific parameter for a city
    [Arguments]    ${jsonPath}
    ...            ${params}
    ${response}    RequestsLibrary.GET    ${API_URL}
    ...                                   ${params}
    RequestsLibrary.Status Should Be    ${CODE_SUCCESS}
    ${temperature}    JSONLibrary.Get Value From Json    ${response.json()}
    ...                                                  ${jsonPath}
    [Return]    ${temperature[0]}

Create Valid Dictionary Of Params
    [Documentation]   Get query params, verify them and create dictionary with valid api parameters
    [Arguments]    ${q}
    ...            ${appid}
    ...            ${units}
    ${params}    BuiltIn.Create Dictionary    q=${q}
    ...                                       appid=${appid}
    ...                                       units=${units}
    ${paramUpdated}    random_list.Default Param    ${params}
    [Return]    ${paramUpdated}
