*** Settings ***
Resource    ../../import.resource

*** Variables ***
${ALERT_TITLE_LOCATOR}    //div[@class='panel-heading']
${ALERT_TEXT_LOCATOR}     //div[@class='panel-heading']/following-sibling::div

*** Keywords ***
Get Unique Page Element
    [Documentation]    Get unique page element
    [Arguments]    ${locator}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${locator}
    ${value}    SeleniumLibrary.Get Text    locator=${locator}
    [Return]    ${value}

Get Random Measure Except
    [Documentation]    Get random temperature measure from exisitng measures except getting as parameter
    [Arguments]    ${existing_measure}
    ${unit_keys}    Collections.Get Dictionary Keys    ${UNITS}
    ${random_meausure}    RandomList.Get Random Item From List    list_items=${unit_keys}
    ...                                                           except_item=${existing_measure}
    [Return]    ${random_meausure}

Format Date From Timestamp
    [Documentation]    Format date from timestamp to required format
    [Arguments]    ${time_stamp_list}
    ...            ${date_format}
    ${formatted_list}    BuiltIn.Create List
    FOR    ${item}    IN    @{time_stamp_list}
        ${item}    CustomDatetime.Get Date From Timestamp In Format    timeStamp=${item}
        ...                                                            date_format=${date_format}
        Collections.Append To List    ${formatted_list}
        ...                           ${item}
    END
    [Return]    ${formatted_list}

Create List Temperature Range From Lists
    [Documentation]    Get lists with min and max temperatures and return combine list with their intervals
    [Arguments]    ${list_max}
    ...            ${list_min}
    ${list_averedge_max}    Common.Round The List    ${list_max}
    ${list_averedge_min}    Common.Round The List    ${list_min}
    ${formatted_list}    BuiltIn.Create List
    FOR    ${item1}    ${item2}    IN ZIP   ${list_averedge_max}    ${list_averedge_min}
        ${item}    BuiltIn.Evaluate    f"{${item1}} / {${item2}}°C"
        Collections.Append To List    ${formatted_list}
        ...                           ${item}
    END
    [Return]    ${formatted_list}

Round The List
    [Documentation]    Round the given list and return it
    [Arguments]    ${list}
    ${round_list}    BuiltIn.Create List
    FOR    ${item}    IN    @{list}
        ${item}    BuiltIn.Evaluate    round(${item})
        Collections.Append To List    ${round_list}
        ...                           ${item}
    END
    [Return]    ${round_list}
