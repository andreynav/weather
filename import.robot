*** Settings ***
Resource        resources/pages/loginPage.robot
Resource        resources/pages/mainPage.robot
Resource        resources/pages/profilePage.robot
Resource        resources/pages/navbar.robot
Resource        resources/common.robot
Resource        resources/hwOneKeywords.robot
Library         resources/currentTime.py
Library         Collections
Variables       data/user.py