*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Variables        ../../Locators/CortecaConsoleLocators.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource            ../../Resources/meshliveCases/setmeshlivetrue.resource



*** Test Cases ***

NWCC_L1BE_USP_Optimization_MeshAPI_02 | Get Mesh API with live true when cache available - Get for dynamic fields
    [Documentation]    NWCC_AIOC_TroubleshootingDashboard_09 Verify Fetch System Logs
    ...                Move to the troubleshooting dashboard
    ...                Trigger And Fetch Logs
    ...                click continue
    ...                wait for log upload activated pop up
    ...                wait for success text
    ...                move to network history tab
    ...                check if the tar file is generated
    [Tags]    USP
    [Teardown]    Qw.closebrowser
    Clearing Hazelcast Cache
    Set Mesh Live True


dsjkjks
    Set Mesh Live True