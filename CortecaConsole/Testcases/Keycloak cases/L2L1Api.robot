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
Resource        ../../Resources/TestSpecificProcedures/keycloak/AdminReadOnly.resource
Resource        ../../Resources/TestSpecificProcedures/keycloak/L1API.resource
Resource        ../../Resources/TestSpecificProcedures/keycloak/caregaent.resource



*** Test Cases ***

BBDT-358270|NWCC_L1BE_Keycloak_CortecaConsoleaccess_SubGroup_04 | Home Controller - L1 and L2 API Access
    [Documentation]     Step1: Action: Connect device to corteca both L1 and L2
     ...             Expected Result: Device should be online in both L1 and L2

     ...             Step2: Action: Open Corteca console with above sub group user
     ...             Expected Result: Home, troubleshooting and FCC broadband compliance apps should be shown

     ...             Step3: Action: Login to device via home troubleshooting dashboard
     ...             Expected Result: Should be able to see live updates and set operations also should be allowed

     ...             Step4: Action: Open FCC broadband compliance and create schedule
     ...             Expected Result: Schedule creation should be successful

     ...             Step5: Action: Do provisioning of any MAC via swagger
     ...             Expected Result: Provisioning should be successful
         ...         Step6: Action: Trigger L2 APIs via swagger
     ...             Expected Result: API response should be successful
    [Tags]    both
    [Teardown]    Qw.closebrowser
    Login To QWEB Browser For Keycloak    ${payload_apisecond}
    Log     Home, troubleshooting and FCC broadband compliance apps should be shown
    Verify Corteca Elements For L1l2api
    Log    Should be able to see live updates and set operations also should be allowed
    Set Permission Allowed    ${payload_apisecond}
    Log    Device should be online in both L1 and L2
    Run Keyword And Continue On Failure    Check the device is online in L1 and L2
    Login To QWEB Browser For Keycloak    ${payload_apisecond}
    Move To Page    FCC Broadband Compliance
    Log    Open FCC broadband compliance and create schedule
    Create Schedule
    Log  Do provisioning of any MAC via swagger
    API DEVICE PROVISION    ${payload_apisecond}
    Log  Trigger L2 APIs via swagger
    L2 API CHECK    ${payload_apisecond}

