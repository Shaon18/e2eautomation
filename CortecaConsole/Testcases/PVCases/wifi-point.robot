*** Settings ***

Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Variables        ../../Locators/CortecaConsoleLocators.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/TestSpecificProcedures/wifi_point.resource

*** Test Cases ***

BBDT-162621_BBDT-162622_BBDT-162617_NWCC_AIOC_HomeDashboard_19_23_24
    [Documentation]    Verify Network Page connected cards,slice cards
    ...                Verify Wifi Point Details Page
    ...                Check Firmware info card
    ...                Check Connectivity info card
    ...                Check Device info card
    ...                Check Wifi Scan Graph
    ...                Check Network History
    ...                Check health card for extenders

    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move To Home Dashboard
    Verification of Connected devices card in network page
    Verification of Wifi-points Detail

