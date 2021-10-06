*** Settings ***
Library                                 SeleniumLibrary

*** Variables ***
${urlLogin}                             https://home.openweathermap.org/users/sign_in
${modalTitleLocator}                    //h3[@class='first-child']
${modalTitleValue}                      Sign In To Your Account
${fieldEmailLocator}                    //div[@class='input-group']/input[@id='user_email']
${fieldPasswordLocator}                 //div[@class='input-group']/input[@id='user_password']
${buttonSubmitLocator}                  //input[@value='Submit']
${allertTitleLocator}                   //div[text()='Alert']
${alertTextValueLocator}                //div[text()='Alert']/following-sibling::div
${alertTextValue}                       Invalid Email or password.
${successfulTitleLocator}               //div[@class='panel-heading']
${successfulTextLocator}                //div[@class='panel-heading']/following-sibling::div
${successfulTextValue}                  Signed in successfully.
${validEmail}                           nav.testsw@gmail.com
${validPassword}                        Qwerty123$

*** Keywords ***
Login With Invalid Credentials
    [Documentation]                     User log in with invalid credentials
    [Arguments]                         ${email}                            ${password}
    Login With Credentials              ${email}                            ${password}
    Alert Should Be Appear

Login With Credentials
    [Documentation]                     User log in with credentials
    [Arguments]                         ${email}                            ${password}
    Go to Sign In Page
    Input Email                         ${email}
    Input Password                      ${password}
    Submit Credentials

Go to Sign In Page
    [Documentation]                     User opens the Sign in page
    Go To                               ${urlLogin}
    Wait Until Element Contains         locator=${modalTitleLocator}        text=${modalTitleValue}

Input Email
    [Documentation]                     User input the email
    [Arguments]                         ${email}
    Wait Until Element Is Visible       locator=${fieldEmailLocator}
    input text                          locator=${fieldEmailLocator}        text=${email}

Input Password
    [Documentation]                     User input the password
    [Arguments]                         ${password}
    Wait Until Element Is Visible       locator=${fieldPasswordLocator}
    input text                          locator=${fieldPasswordLocator}     text=${password}

Submit Credentials
    [Documentation]                     User clicks the button Submit
    Click Element                       locator=${buttonSubmitLocator}

Alert Should Be Appear
    [Documentation]                     The warning alert that email or password is invalid is displayed
    Wait Until Element Is Visible       locator=${allertTitleLocator}
    Wait Until Element Contains         locator=${alertTextValueLocator}    text=${alertTextValue}

Succesful Notice Should Be Appear
    [Documentation]                     The notification that user signed in successfully is displayed
    Wait Until Element Is Visible       locator=${successfulTitleLocator}
    Wait Until Element Contains         locator=${successfulTextLocator}    text=${successfulTextValue}