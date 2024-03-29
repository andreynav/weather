*** Settings ***
Resource    ../../../import.resource

*** Variables ***
${LOGIN_EMAIL_FIELD_LOCATOR}       //div[@class='input-group']/input[@id='user_email']
${LOGIN_MODAL_TITLE_LOCATOR}       //h3[@class='first-child']
${LOGIN_MODAL_TITLE_VALUE}         Sign In To Your Account
${LOGIN_PASSWORD_FIELD_LOCATOR}    //div[@class='input-group']/input[@id='user_password']
${LOGIN_SUBMIT_BUTTON_LOCATOR}     //input[@value='Submit']

*** Keywords ***
Go To Sign In Page
    [Documentation]    User opens the Sign In page
    SeleniumLibrary.Go To   ${URL_LOGIN}

Input Email
    [Documentation]    User inputs the email
    [Arguments]    ${email}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${LOGIN_EMAIL_FIELD_LOCATOR}
    SeleniumLibrary.Input Text    locator=${LOGIN_EMAIL_FIELD_LOCATOR}
    ...                           text=${email}

Input Password
    [Documentation]    User inputs the password
    [Arguments]    ${password}
    SeleniumLibrary.Wait Until Element Is Visible    locator=${LOGIN_PASSWORD_FIELD_LOCATOR}
    SeleniumLibrary.Input Text    locator=${LOGIN_PASSWORD_FIELD_LOCATOR}
    ...                           text=${password}

Submit Credentials
    [Documentation]    User clicks the button Submit
    SeleniumLibrary.Wait Until Element Is Visible    locator=${LOGIN_SUBMIT_BUTTON_LOCATOR}
    SeleniumLibrary.Click Element    locator=${LOGIN_SUBMIT_BUTTON_LOCATOR}
