*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource       ../../Resources/TestSpecificProcedures/fetchlogsupport.robot



*** Test Cases ***

    
BBDT-176381 NWCC_AIOC_TroubleshootingDashboard_09 | Verify Fetch System Logs
    [Documentation]    NWCC_AIOC_TroubleshootingDashboard_09 Verify Fetch System Logs
    ...                Move to the troubleshooting dashboard
    ...                Trigger And Fetch Logs
    ...                click continue
    ...                wait for log upload activated pop up
    ...                wait for success text
    ...                move to network history tab
    ...                check if the tar file is generated
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move To Home Dashboard
    Open SA Network Device
    Trigger And Fetch Logs
    
    
