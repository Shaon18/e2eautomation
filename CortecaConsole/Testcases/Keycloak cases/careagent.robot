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
Resource        ../../Resources/TestSpecificProcedures/keycloak/caregaent.resource




*** Test Cases ***


BBDT-358184|NWCC_L1BE_Keycloak_CortecaConsoleaccess_SubGroup_02 | Home Controller - Care Agent - Read Only Access
    [Documentation]    Step1: Action: Connect device to corteca both L1 and L2
      ...                  Expected Result: Device should be online in both L1 and L2

      ...                  Step2: Action: Open Corteca console with above sub group user
      ...                  Expected Result: Home and troubleshooting app should be shown

      ...                  Step3: Action: Login to device via home and troubleshooting dashboard
      ...                  Expected Result: Should be able to see live updates and set operations should not be allowed or masked
    [Tags]    both
    [Teardown]    Qw.closebrowser
    Login To QWEB Browser For Keycloak    ${payload_carereadonly}
    Verify Corteca Elements For Careagent Readonly
    Run Keyword And Continue On Failure    Check the device is online in L1 and L2



BBDT-358053|NWCC_L1BE_Keycloak_CortecaConsoleaccess_SubGroup_01 | Home Controller - Care Agent - Full Access
    [Documentation]    Step1: Action: Connect device to corteca both L1 and L2
      ...                  Expected Result: Device should be online in both L1 and L2

      ...                  Step2: Action: Open Corteca console with above sub group user
      ...                  Expected Result: Home, troubleshooting and WiFi Optimization apps should be shown

      ...                  Step3: Action: Login to device via home troubleshooting dashboard
      ...                  Expected Result: Should be able to see live updates and set operations also should be allowed

      ...                  Step4: Action: Open WiFi optimization
      ...                  Expected Result: Except geographical deployment all other menus should be shown and allowed to set any configurations
    [Tags]    both
    [Teardown]    Qw.closebrowser
    Login To QWEB Browser For Keycloak    ${payload_carefullaccess}
    Verify Corteca Elements For Careagent Admin
    
   
   
   


    
