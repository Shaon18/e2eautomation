*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Variables           ../../Locators/CortecaConsoleLocators.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/TestSpecificProcedures/speedtest.resource

*** Test Cases ***

BBDT162626_NWCC_AIOC_HomeDashboard_28 Verify Speed Test History Table
    [Documentation]    NWCC_AIOC_HomeDashboard_28 Verify Speed Test History Table
    ...                Check download,upload speed ,ping,jitter and compare it with the 1st result of the history table
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move To Home Dashboard
    Check Speed Test History Table




BBDT162625_NWCC_AIOC_HomeDashboard_27 Verify Speed Test Page in Home Dashboard
    [Documentation]    NWCC_AIOC_HomeDashboard_28 Verify Speed Test Page in Home Dashboard
    ...                Check download,upload speed ,ping,jitter and download symbol present or not
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move To Home Dashboard
    Verify SPeed Test Card




