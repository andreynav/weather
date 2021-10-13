*** Settings ***
Library                                                 SeleniumLibrary

*** Variables ***
${LOGIN_ALERT_FAIL_TITLE_LOCATOR}                       //div[text()='Alert']
${LOGIN_ALERT_FAIL_TEXT_VALUE_LOCATOR}                  //div[text()='Alert']/following-sibling::div
${LOGIN_ALERT_FAIL_TEXT_VALUE}                          Invalid Email or password.
${LOGIN_ALERT_SUCCESS_TITLE_LOCATOR}                    //div[@class='panel-heading']
${LOGIN_ALERT_SUCCESS_TEXT_LOCATOR}                     //div[@class='panel-heading']/following-sibling::div
${LOGIN_ALERT_SUCCESS_TEXT_VALUE}                       Signed in successfully.
${LOGIN_EMAIL_FIELD_LOCATOR}                            //div[@class='input-group']/input[@id='user_email']
${LOGIN_MODAL_TITLE_LOCATOR}                            //h3[@class='first-child']
${LOGIN_MODAL_TITLE_VALUE}                              Sign In To Your Account
${LOGIN_PASSWORD_FIELD_LOCATOR}                         //div[@class='input-group']/input[@id='user_password']
${LOGIN_SUBMIT_BUTTON_LOCATOR}                          //input[@value='Submit']
${LOGIN_URL}                                            https://home.openweathermap.org/users/sign_in

*** Keywords ***
Login With Credentials
    [Documentation]                                     User log in with credentials
    [Arguments]                                         ${email}                                        ${password}
    loginPage.Input Email                               ${email}
    loginPage.Input Password                            ${password}
    loginPage.Submit Credentials

Open Sign In Page
    [Documentation]                                     User opens the Sign In page
    SeleniumLibrary.Go To                               ${LOGIN_URL}
    SeleniumLibrary.Wait Until Element Contains         locator=${LOGIN_MODAL_TITLE_LOCATOR}            text=${LOGIN_MODAL_TITLE_VALUE}

Input Email
    [Documentation]                                     User inputs the email
    [Arguments]                                         ${email}
    SeleniumLibrary.Wait Until Element Is Visible       locator=${LOGIN_EMAIL_FIELD_LOCATOR}
    SeleniumLibrary.Input Text                          locator=${LOGIN_EMAIL_FIELD_LOCATOR}            text=${email}

Input Password
    [Documentation]                                     User inputs the password
    [Arguments]                                         ${password}
    SeleniumLibrary.Wait Until Element Is Visible       locator=${LOGIN_PASSWORD_FIELD_LOCATOR}
    SeleniumLibrary.Input Text                          locator=${LOGIN_PASSWORD_FIELD_LOCATOR}         text=${password}

Submit Credentials
    [Documentation]                                     User clicks the button Submit
    SeleniumLibrary.Click Element                       locator=${LOGIN_SUBMIT_BUTTON_LOCATOR}

Verify Alert Is Appeared
    [Documentation]                                     The warning alert that email or password is invalid is displayed
    SeleniumLibrary.Wait Until Element Is Visible       locator=${LOGIN_ALERT_FAIL_TITLE_LOCATOR}
    SeleniumLibrary.Wait Until Element Contains         locator=${LOGIN_ALERT_FAIL_TEXT_VALUE_LOCATOR}  text=${LOGIN_ALERT_FAIL_TEXT_VALUE}

Verify Successful Notice Is Appeared
    [Documentation]                                     The notification that user signed in successfully is displayed
    SeleniumLibrary.Wait Until Element Is Visible       locator=${LOGIN_ALERT_SUCCESS_TITLE_LOCATOR}
    SeleniumLibrary.Wait Until Element Contains         locator=${LOGIN_ALERT_SUCCESS_TEXT_LOCATOR}     text=${LOGIN_ALERT_SUCCESS_TEXT_VALUE}

Verify Sign In Page Is Opened
    [Documentation]                                     The Sign In page is opened
    SeleniumLibrary.Wait Until Location Is              ${LOGIN_URL}