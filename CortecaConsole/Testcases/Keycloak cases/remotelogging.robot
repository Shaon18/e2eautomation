*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/KeywordDefinition/Keycloakresources.resource
Variables     ../../Resources/TestDatas.py



*** Test Cases ***


BBDT-353188|NWCC_USP_RemoteLogging_01 | Verify Remote Logging page based on Login Role defined in Keycloak
    [Documentation]    Check if Corteca console should display Remote Logging section in Troubleshooting dashboard when “sv_remote_access” keycloak role associated to user login credentials.
    [Tags]    both
    [Teardown]    Qw.closebrowser
    Login To QWEB Browser For Keycloak    ${payload_fullaccess}
    Check And Move To Homedashboard
    VerifyText    Remote Logging    30s
    Qwebelement.clicktext    Remote Logging
    VerifyText    Session log - Last 15min
