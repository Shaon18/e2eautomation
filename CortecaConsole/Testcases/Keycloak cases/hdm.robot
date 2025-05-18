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
Resource        ../../Resources/TestSpecificProcedures/keycloak/hdm.resource




*** Test Cases ***


BBDT-358487|NWCC_L1BE_Keycloak_CortecaConsoleaccess_SubGroup_09 | Home Controller - HDM
    [Documentation]   Step1: Action: Connect device to corteca both L1 and L2
     ...             Expected Result: Device should be online in both L1 and L2

     ...             Step2: Action: Open Corteca console with above sub group user
     ...             Expected Result: Home, troubleshooting apps and HDM application plugins should be shown

     ...             Step3: Action: Login to device via home troubleshooting dashboard
     ...             Expected Result: Should be able to see live updates and set operations also should be allowed

     ...             Step4: Action: Click HDM -> management console plugin
     ...             Expected Result: It should redirect to HDM console

     ...             Step5: Action: Click HDM -> campaign manager plugin
     ...             Expected Result: It should redirect to HDM campaign manager
    [Tags]    both
    [Teardown]    Qw.closebrowser
    Login To QWEB Browser For Keycloak    ${payload_hdmgeneral}
    Log    Home, troubleshooting apps and HDM application plugins should be shown
    Verify Corteca Elements For HDM
