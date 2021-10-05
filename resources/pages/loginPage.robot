*** Settings ***
Library                                 SeleniumLibrary

*** Variables ***
${pageLoginUrl}                         https://home.openweathermap.org/users/sign_in
${pageTitleLocator}                     //h3[@class='first-child']
${pageTitleText}                        Sign In To Your Account
${fieldEmail}                           //div[@class='input-group']/input[@id='user_email']
${fieldPassword}                        //div[@class='input-group']/input[@id='user_password']
${buttonSubmit}                         //input[@value='Submit']
${allertTitleLocator}                   //div[text()='Alert']
${alertTextLocator}                     //div[text()='Alert']/following-sibling::div
${alertText}                            Invalid Email or password.
${successfulNoticeTitleLocator}         //div[@class='panel-heading']
${successfulNoticeTextLocator}          //div[@class='panel-heading']/following-sibling::div
${successfulNoticeText}                 Signed in successfully.
${validEmail}                           nav.testsw@gmail.com
${validPassword}                        Qwerty123$

*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]                         ${email}    ${password}
    Go to Sign In Page
    Input Email                         ${email}
    Input Password                      ${password}
    Submit Credentials
    Alert Should Be Appear

Go to Sign In Page
    Go To                               ${pageLoginUrl}
    Wait Until Element Contains         locator=${pageTitleLocator}                 text=${pageTitleText}

Input Email
    [Arguments]                         ${email}
    Wait Until Element Is Visible       locator=${fieldEmail}
    input text                          locator=${fieldEmail}                       text=${email}

Input Password
    [Arguments]                         ${password}
    Wait Until Element Is Visible       locator=${fieldPassword}
    input text                          locator=${fieldPassword}                    text=${password}

Submit Credentials
    Click Element                       locator=${buttonSubmit}

Alert Should Be Appear
    Wait Until Element Is Visible       locator=${allertTitleLocator}
    Wait Until Element Contains         locator=${alertTextLocator}                 text=${alertText}

Succesful Notice Should Be Appear
    Wait Until Element Is Visible       locator=${successfulNoticeTitleLocator}
    Wait Until Element Contains         locator=${successfulNoticeTextLocator}      text=${successfulNoticeText}