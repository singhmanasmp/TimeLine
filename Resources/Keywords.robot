*** Settings ***
Documentation       This file contains the common methods/keywords for UI operations
Library             SeleniumLibrary     timeout=20s
Variables           ../Resources/Variables.py
Resource            ../Resources/Locaters.robot

*** Keywords ***

Launch application
    Open Browser                              ${URL}       ${Browser_Type}
    Wait Until Page Contains Element          ${Go_To_First_Button}
    Maximize Browser Window
    log     Application launched successfully!


Focus on first event
    ${go_to_first_attr_value} =   get element attribute    ${Go_To_First_Button}     aria-disabled
    ${previous_attr_value} =    get element attribute    ${Previous_Button}     aria-disabled
    should be equal    ${go_to_first_attr_value}    true
    should be equal    ${previous_attr_value}    true


Focus on last event
    click element    ${Go_To_Last_Button}
    sleep            2s
    ${go_to_last_attr_value} =   get element attribute    ${Go_To_Last_Button}     aria-disabled
    ${next_attr_value} =    get element attribute    ${Next_Button}     aria-disabled
    should be equal    ${go_to_last_attr_value}    true
    should be equal    ${next_attr_value}    true


Previous and Next buttons
    reload page
    wait until page contains element    ${Next_Button}
    FOR     ${event}    IN     ${TimeLine_Item_Node}
        click element    ${Next_Button}
        sleep    2s
        ${current_event} =   get element attribute  ${event}   class
        should contain    ${current_event}     in-active
        click element    ${Previous_Button}
        sleep    2s
        ${current_event} =   get element attribute  ${event}   class
        should not contain    ${current_event}     in-active
    END


Go to First and Previous buttons enable
    reload page
    wait until page contains element    ${Next_Button}
    click element    ${Next_Button}
    ${go_to_first_attr_value} =   get element attribute    ${Go_To_First_Button}     aria-disabled
    ${previous_attr_value} =    get element attribute    ${Previous_Button}     aria-disabled
    should be equal    ${go_to_first_attr_value}    false
    should be equal    ${previous_attr_value}    false


Switching to Light mode
    click element    ${Dark_Mode_Button}
    wait until page contains element    ${Light_Mode_Button}
    page should not contain element     ${Dark_Mode_Button}


Switching to Dark mode
    click element    ${Light_Mode_Button}
    wait until page contains element    ${Dark_Mode_Button}
    page should not contain element     ${Light_Mode_Button}


Read more link presence
    wait until page contains element    ${Read_More_Link}
    click element    ${Read_More_Link}
    sleep   2s
    page should contain element    ${Read_Less_Link}


Read less link presence
    click element    ${Read_Less_Link}
    wait until page contains element    ${Read_More_Link}
    page should not contain element    ${Read_Less_Link}


Navigating forward through the timeline events
    FOR    ${event}     IN     ${TimeLine_Item_Node}
        ${event_date} =  get element attribute    ${event}     aria-label
        ${event_focus} =  get element attribute    ${event}     class
        wait until page contains element    ${Next_Button}
        should not contain    ${event_focus}    in-active
        click element    ${Next_Button}
        ${next_attr_value} =    get element attribute    ${Next_Button}     aria-disabled
        ${go_to_last_attr_value} =   get element attribute    ${Go_To_Last_Button}     aria-disabled
        exit for loop if     '${next_attr_value}' == 'true' and '${go_to_last_attr_value}' == 'true'
    END
