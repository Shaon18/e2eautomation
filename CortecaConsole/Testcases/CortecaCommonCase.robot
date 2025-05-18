*** Settings ***
Resource    ../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource    ../Resources/KeywordDefinition/Sshkeywords.resource
Resource    ../Resources/KeywordDefinition/WebGUIAccessControlEnable.resource
Resource    ../Resources/TestSpecificProcedures/AccountCreationAPI.resource
Resource    ../Resources/TestSpecificProcedures/ExtenderOnboardingCGI.resource
Resource    ../Resources/TestSpecificProcedures/ConfigureBoengSSH.resource
Variables    ../Resources/TestDatas.py

*** Test Cases ***
BBDT-30759_NWCC_L1_BoENG_1 | BBDT-30765_NWCC_L1_BoENG_7
    [Documentation]    Testcase covered:
    ...
    ...    NWCC_L1_BoENG_1 and NWCC_L1_BoENG_7
    ...    Testcase objective:
    ...    A BOENG agent resides in the Beacon with RGW mode to fetch auto configuration data on factory default and when ACS URL is default one.
    ...    BoENG Agent will start running when the ACS URL is empty or when the ACS URL is default one. Agent will be triggered on next poll or reboot
    ...    Once BoENG agent receives the ACS URL from the BoENG server, BoENG agent will be stopped
    ...    BOENG agent should not run after software muigration, provided there is no factory default condition after software upgrade.
    ...
    ...    On giving factory default, the root beacon should start the boeng agent automatically and get all the required information from the boeng server and configure the same
    ...    Supports Beacons, check HA/USP boeng Mapping with
    ...    Author: [sangeeth.kumar_t@nokia.com]
    [Tags]    Both    smoke    pvcase
    [Teardown]    Close all connections
    Run Keyword And Continue On Failure    EnableAccessControl
    Run Keyword And Continue On Failure    ConfigureBoeng

BBDT-30821_NWCC_L1_Onboarding_1 | BBDT-30760_NWCC_L1_BoENG_2
    [Documentation]    Testcase covered:
    ...                 
    ...               NWCC_L1_BoENG_2 ::  Testcase objective:
                     
    ...                Objective Verify the following functionality of BoENG Server 
    ...                Check the Onboarding URL and it is fixed to httpsonboard.wifi.nokia.com 
    ...                BOENG Agent polls BOENG server for every 30 mins on every power cycle 
    ...                BOENG checks for operator + country from the source IP and finds out the Operator ID and Country. 
    ...                BOENG Server finds out the ACS URL for the identified operator ID and Country and sends the same to BoENG Agent 
    ...                BoENG server identifies the time zone information based on the IP address and send the same to the BoENG Agent. 
    ...                BoENG server identifies the applicable power table and share the same to the BoENG Agent 
    ...                BoENG server also identifies the L1 MQTT URL, L2 HTTP URL and remote mobile app URL to BoENG Agent 
    ...                Check Whether L1, L2 and Mobile App URL is correctly updated in the data model 
    ...                BOENG agent on receiving this, triggers ACS connection.On successful ACS connection, BOENG Agent in nokia wifi beacon is stopped 
    ...                Author: [sangeeth.kumar_t@nokia.com]
    [Tags]    Both    smoke   pvcase
    Run Keyword And Continue On Failure    NWCC_AccountCreation_API
    Run Keyword And Continue On Failure    Extender_Onboarding_CGI

OSSBBS_RemoveBeacon_API_1 
    [Documentation]    Test Case Covered :: OSSBBS_RemoveBeacon_API_1
    ...    Remove BeaconExtender - Verify that ossbss sends notification to Home console to remove the beacon from the customer setup. The entry of this extender beacon is removed from the whitelist DB.The entry of this Extender beacon is removed from the root beacon mesh table. Check Home console and Mobile app after removal 
    ...    Author: [sangeeth.kumar_t@nokia.com]
    [Tags]    Both    
    Delete Extender via API

OSSBBS_RemoveSubsc_API_1
   [Documentation]    Test Case Covered :: OSSBBS_RemoveSubsc_API_1 
   ...                Remove SubscriberSuccess Scenario - Verify that all the information related to the subscriber is removed from the home console, network console and Keycloak DB. Entries related to beacons of the end user is removed from the whitelist database. Entries in the root beacon is removed.
   ...                Author: [sangeeth.kumar_t@nokia.com]
   [Tags]    Both    
   Delete Subscriber via API
   comment    Login To Corteca Console
   comment    Open Corteca Console Home Page    Serial
   comment    Logout From Corteca Console




    
    





    

