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
Resource        ../../Resources/TestSpecificProcedures/keycloak/FMC.resource





*** Test Cases ***

BBDT-358476|NWCC_L1BE_Keycloak_CortecaConsoleaccess_SubGroup_07 | Home Controller - FMC
    [Documentation]    Step1: Action: Connect device to corteca both L1 and L2
      ...                  Expected Result: Device should be online in both L1 and L2

      ...                  Step2: Action: Open Corteca console with above sub group user
      ...                  Expected Result: Home, troubleshooting apps and fmc browser application plugin should be shown

      ...                  Step3: Action: Login to device via home troubleshooting dashboard
      ...                  Expected Result: Should be able to see live updates and set operations also should be allowed

      ...                  Step4: Action: Click FMC -> cpe browser plugin
      ...                  Expected Result: It should redirect to FMC browser UI
    [Tags]    both
    [Teardown]    Qw.closebrowser
    Login To QWEB Browser For Keycloak    ${payload_fmcuser}
    Log    Home, troubleshooting apps and fmc browser application plugin should be shown
    Verify Corteca Elements For Fmc




BBDT-358481|NWCC_L1BE_Keycloak_CortecaConsoleaccess_SubGroup_08 | Home Controller - FMC Admin
    [Documentation]    Step1: Action: Connect device to corteca both L1 and L2
      ...                  Expected Result: Device should be online in both L1 and L2

      ...                  Step2: Action: Open Corteca console with above sub group user
      ...                  Expected Result: Home, troubleshooting apps and fmc browser application plugin should be shown

      ...                  Step3: Action: Login to device via home troubleshooting dashboard
      ...                  Expected Result: Should be able to see live updates and set operations also should be allowed

      ...                  Step4: Action: Click FMC -> cpe browser plugin
      ...                  Expected Result: It should redirect to FMC browser UI
      ...                  Step5: Action: Click FMC -> radio planner plugin
       ...                   Expected Result: It should redirect to FMC radio planner UI
                      
    [Tags]    both
    [Teardown]    Qw.closebrowser
    Login To QWEB Browser For Keycloak    ${payload_fmcadmin}
    Log    Home, troubleshooting apps and fmc browser application plugin should be shown
    Verify Corteca Elements For Fmc Admin



