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
Resource      ../../Resources/TestSpecificProcedures/NEWPV/factoryreset.resource
Library      ../../Resources/commonPythonKeywords/mobileappp.py




*** Test Cases ***

BBDT-176380|NWCC_AIOC_TroubleshootingDashboard_08 | Verify Wi-Fi Point Factory Reset for both Root and EXT
    [Documentation]    1. Only Online Wi-Fi Points should be listed in the drop down menu
    ...                2. Factory Reset EXT Wi-Fi Point and check if the EXT beacon goes for reset. Upon boot-up it should join the Mesh network and come online with Plasmodium established.
    ...                3. Factory Reset Root Wi-Fi Point and check if Reboot beacon goes for restart and intermittent offline and restore to online state during WAN Up.
    ...                4. If Root is Factory reset, the EXT should be removed from the Root beacon entry and it should be re-onboarded to form the mesh again.
    ...                 5. Check if an Event is logged in the Network History respectively for Root and EXT.] [Data:] [Expected Result:]
    [Tags]    Both
    [Teardown]    Qw.closebrowser
    Trigger Factory Reset From Portal