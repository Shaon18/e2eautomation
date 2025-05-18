*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Resource        ../Resources/TestSpecificProcedures/RestartRadioKeywords.robot
Resource        ../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../Resources/KeywordDefinition/ApiRequest.resource

*** Test Cases ***
BBDT-280317_NWCC_AIOC_USP_TroubleshootingDashboard_02_03_04
    [Documentation]
    [Tags]    USP  smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move To Home Dashboard
    Trigger Restart Radio for Root and Extenders
    