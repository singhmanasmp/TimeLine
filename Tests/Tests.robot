*** Settings ***
Documentation       This project will test the timeline application
Library             SeleniumLibrary     timeout=20s
Library             CSVLibrary
Library             Collections
Resource            ../Resources/Variables.py
Resource            ../Resources/Locaters.robot
Resource            ../Resources/Keywords.robot

Suite Setup         Run Keywords     Launch application
Suite Teardown      Close Browser

*** Test Cases ***
TC1: Focus on first event on application launch | Go to First and Previous buttons disabled
    [Documentation]                         This test case will check focus on 1st timeline event and disabled buttons
    [Tags]                                  Positive    Functional
    Focus on first event


TC2: Previous and Next button functionality check
    [Documentation]                         This test case will check the Previous and Next button functionality
    [Tags]                                  Positive    Functional
    Previous and Next buttons


TC3: Focus on last event | Go to Last and Next buttons disabled | Go to last button check
    [Documentation]                         This test case will check focus on last timeline event, go to last and disabled buttons
    [Tags]                                  Positive    Functional
    Focus on last event


TC4: Go to First and Previous buttons enabled
    [Documentation]                         This test case will check focus go to first and Previous button functionality and enablement
    [Tags]                                  Positive    Functional
    Go to First and Previous buttons enable


TC5: Page refresh shifts the focus on the first node
    [Documentation]                         This test case will check page refresh functionality
    [Tags]                                  Positive    Functional
    Focus on last event
    reload page
    sleep    3s
    Focus on first event


TC6: Switch to Dark/Light modes
    [Documentation]                         This test case will check switching to Light and Dark modes
    [Tags]                                  Positive    Functional
    Switching to Light mode
    Switching to Dark mode


TC7: Read more/less link check
    [Documentation]                         This test case will check the read more link
    [Tags]                                  Positive    Functional
    Focus on last event
    Read more link presence
    Read less link presence