*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/TestSpecificProcedures/keycloak/delbeacon.resource





*** Test Cases ***


BBDT-197469|NWCC_L1_NWCC_specificfeature_UUID_08 | In keycloak account topologydeletedtime should not be added during extender delete
    [Documentation]    Step 1: Action: Create account via MAPP and onboard 1 extender and care agent search with root MACExpected Result: Mesh formed and search with MAC should show associated account detailsStep 2: Action: In Get topology API - GET /homehub/networks/{home_wifi_id}/topology

      ...                  Expected Result: All devices in mesh should be shown

      ...                  Step 3: Action: Trigger delete extender beacons API with force true and reset as false with UUID and extender MAC as input

      ...                  DELETE /subscribers/subscribers/{uuid}/devices/{device_id}?force=true&factory_reset=false

      ...                  Expected Result: All info in NWCC should be deleted for the extender

      ...                  Step 4: Action: Search with extender MAC in care agent search page

      ...                  Expected Result: No data available should come

      ...                  Step 5: Action: Check attributes section of account in keycloak

      ...                  Expected Result: topologydeletedtime should not be created
    [Tags]    nope
    [Teardown]    Qw.closebrowser
    Move To Home Dashboard
    Verifytopo Deleted Time    ${meshNodes}[0]
    Add Back    ${meshNodes}[0]
    
